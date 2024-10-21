import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../main.dart';
import '../../../enums/language/highlight/mode.dart';
import '../code_editor.dart';
import '../code/code_edit_result.dart';
import '../single_line_comments/parser/single_line_comments.dart';
import 'span_builder.dart';

class CodeController extends TextEditingController {
  Mode? _language;

  /// A highlight language to parse the text with
  ///
  /// Setting a language will change the analyzer to [DefaultLocalAnalyzer].
  Mode? get language => _language;

  set language(Mode? language) {
    setLanguage(language);
  }

  String _lastAnalyzedText = '';
  Timer? _debounce;

  final AbstractNamedSectionParser? namedSectionParser;
  Set<String> _readOnlySectionNames;

  /// A map of specific regexes to style
  final Map<String, TextStyle>? patternMap;

  /// Common editor params such as the size of a tab in spaces
  ///
  /// Will be exposed to all [modifiers]
  final EditorParams params;

  /// A list of code modifiers
  /// to dynamically update the code upon certain keystrokes.
  final List<CodeModifier> modifiers;

  final bool _isTabReplacementEnabled;

  /* Computed members */
  String _languageId = '';

  ///Contains names of named sections, those will be visible for user.
  ///If it is not empty, all another code except specified will be hidden.
  Set<String> _visibleSectionNames = {};

  /// Makes the text un-editable, but allows to set the full text.
  /// Focusing and moving the selection inside of a [CodeField] will
  /// still be possible.
  final bool readOnly;

  String get languageId => _languageId;

  Code _code;

  final _styleList = <TextStyle>[];
  final _modifierMap = <String, CodeModifier>{};

  /// The last [TextSpan] returned from [buildTextSpan].
  ///
  /// This can be used in tests to make sure that the updated text  was actually
  /// requested by the widget and thus notifications are done right.
  @visibleForTesting
  TextSpan? lastTextSpan;

  CodeController({
    String? text,
    Mode? language,
    this.namedSectionParser,
    Set<String> readOnlySectionNames = const {},
    Set<String> visibleSectionNames = const {},
    this.patternMap,
    this.readOnly = false,
    this.params = const EditorParams(),
    this.modifiers = const [
      IndentModifier(),
      CloseBlockModifier(),
      TabModifier(),
    ],
  })  : _readOnlySectionNames = readOnlySectionNames,
        _code = Code.empty,
        _isTabReplacementEnabled = modifiers.any((e) => e is TabModifier) {
    setLanguage(language);
    this.visibleSectionNames = visibleSectionNames;
    _code = _createCode(text ?? '');
    fullText = text ?? '';

    addListener(_scheduleAnalysis);

    // Create modifier map
    for (final el in modifiers) {
      _modifierMap[el.char] = el;
    }

    // Build styleRegExp
    final patternList = <String>[];
    if (patternMap != null) {
      patternList.addAll(patternMap!.keys.map((e) => '($e)'));
      _styleList.addAll(patternMap!.values);
    }
  }

  void _scheduleAnalysis() {
    _debounce?.cancel();

    if (_lastAnalyzedText == _code.text) {
      // If the last analyzed code is the same as current code
      // we don't need to analyze it again.
      return;
    }
  }

  void setLanguage(Mode? language) {


    if (language != null) {
      _languageId = language.hashCode.toString();
      highlight.registerLanguage(_languageId, language);
    }

    _language = language;
    _updateCode(_code.text);
    notifyListeners();
  }

  /// Sets a specific cursor position in the text
  void setCursor(int offset) {
    selection = TextSelection.collapsed(offset: offset);
  }

  /// Replaces the current [selection] by [str]
  void insertStr(String str) {
    final sel = selection;
    text = text.replaceRange(selection.start, selection.end, str);
    final len = str.length;

    selection = sel.copyWith(
      baseOffset: sel.start + len,
      extentOffset: sel.start + len,
    );
  }

  /// Remove the char just before the cursor or the selection
  void removeChar() {
    if (selection.start < 1) {
      return;
    }

    final sel = selection;
    text = text.replaceRange(selection.start - 1, selection.start, '');

    selection = sel.copyWith(
      baseOffset: sel.start - 1,
      extentOffset: sel.start - 1,
    );
  }

  /// Remove the selected text
  void removeSelection() {
    final sel = selection;
    text = text.replaceRange(selection.start, selection.end, '');

    selection = sel.copyWith(
      baseOffset: sel.start,
      extentOffset: sel.start,
    );
  }

  /// Remove the selection or last char if the selection is empty
  void backspace() {
    if (selection.start < selection.end) {
      removeSelection();
    } else {
      removeChar();
    }
  }

  KeyEventResult onKey(KeyEvent event) {
    return KeyEventResult.ignored; // The framework will handle.
  }

  String get fullText => _code.text;

  set fullText(String fullText) {
    _updateCodeIfChanged(_replaceTabsWithSpacesIfNeeded(fullText));
    super.value = TextEditingValue(text: _code.visibleText);
  }

  int? _insertedLoc(String a, String b) {
    final sel = selection;

    if (a.length + 1 != b.length || sel.start != sel.end || sel.start == -1) {
      return null;
    }

    return sel.start;
  }

  @override
  set value(TextEditingValue newValue) {
    final hasTextChanged = newValue.text != super.value.text;
    final hasSelectionChanged = newValue.selection != super.value.selection;

    if (!hasTextChanged && !hasSelectionChanged) {
      return;
    }

    if (hasTextChanged) {
      final loc = _insertedLoc(text, newValue.text);

      if (loc != null) {
        final char = newValue.text[loc];
        final modifier = _modifierMap[char];
        final val = modifier?.updateString(text, selection, params);

        if (val != null) {
          // Update newValue
          newValue = newValue.copyWith(
            text: val.text,
            selection: val.selection,
          );
        }
      }

      if (_isTabReplacementEnabled) {
        newValue = newValue.tabsToSpaces(params.tabSpaces);
      }

      final editResult = _getEditResultNotBreakingReadOnly(newValue);

      if (editResult == null) {
        return;
      }

      final selectionSnapshot =
          code.hiddenRanges.recoverSelection(newValue.selection);
      _updateCodeIfChanged(editResult.fullTextAfter);

      if (newValue.text != _code.visibleText) {
        if (newValue.text.length > _code.visibleText.length) {
          // Manually typed in a text that has become a hidden range.
          newValue = newValue.replacedText(_code.visibleText);
        } else {
          // Some folded block is unfolded.
          newValue = TextEditingValue(
            text: _code.visibleText,
            selection: _code.hiddenRanges.cutSelection(selectionSnapshot),
          );
        }
      }
    }

    super.value = newValue;
  }

  void outdentSelection() {
    final tabSpaces = params.tabSpaces;
    if (selection.start == -1 || selection.end == -1) {
      return;
    }

    modifySelectedLines((line) {
      if (line == '\n') {
        return line;
      }

      if (line.length < tabSpaces) {
        return line.trimLeft();
      }

      final subStr = line.substring(0, tabSpaces);
      if (subStr == ' ' * tabSpaces) {
        return line.substring(tabSpaces, line.length);
      }
      return line.trimLeft();
    });
  }

  void indentSelection() {
    final tabSpaces = params.tabSpaces;
    final tab = ' ' * tabSpaces;
    final lines = _code.lines.lines;
    if (selection.start == -1 || selection.end == -1) {
      return;
    }

    if (selection.isCollapsed) {
      final fullPosition = _code.hiddenRanges.recoverPosition(
        selection.start,
        placeHiddenRanges: TextAffinity.downstream,
      );
      final lineIndex = _code.lines.characterIndexToLineIndex(fullPosition);
      final columnIndex = fullPosition - lines[lineIndex].textRange.start;
      final insert = ' ' * (tabSpaces - (columnIndex % tabSpaces));
      value = value.replaced(selection, insert);
      return;
    }

    modifySelectedLines((line) {
      if (line == '\n') {
        return line;
      }
      return tab + line;
    });
  }

  /// Comments out or uncomments the currently selected lines.
  ///
  /// Doesn't affect empty lines.
  ///
  /// If any of the selected lines is not a single line comment:
  /// adds one level of single line comment to every selected line.
  ///
  /// If all of the selected lines are single line comments:
  /// removes one level of single line comment from every selected line.
  ///
  /// When commenting out, adds `// ` or `# ` (or another symbol depending on a language) with a space after.
  /// Removes these spaces on uncommenting.
  /// (if there are no spaces just removes the comments)
  ///
  /// The method doesn't account for multiline comments
  /// and treats them as a normal text (not a comment).
  void commentOutOrUncommentSelection() {
    if (_anySelectedLineUncommented()) {
      _commentOutSelectedLines();
    } else {
      _uncommentSelectedLines();
    }
  }

  bool _anySelectedLineUncommented() {
    return _anySelectedLine((line) {
      for (final commentType in SingleLineComments.byMode[language] ?? []) {
        if (line.trimLeft().startsWith(commentType) ||
            line.hasOnlyWhitespaces()) {
          return false;
        }
      }
      return true;
    });
  }

  /// Whether any of the selected lines meets the condition in the callback.
  bool _anySelectedLine(bool Function(String line) callback) {
    if (selection.start == -1 || selection.end == -1) {
      return false;
    }

    final selectedLinesRange = getSelectedLineRange();

    for (int i = selectedLinesRange.start; i < selectedLinesRange.end; i++) {
      final currentLineMatchesCondition = callback(_code.lines.lines[i].text);
      if (currentLineMatchesCondition) {
        return true;
      }
    }

    return false;
  }

  void _commentOutSelectedLines() {
    final sequence = SingleLineComments.byMode[language]?.first;
    if (sequence == null) {
      return;
    }

    modifySelectedLines((line) {
      if (line.hasOnlyWhitespaces()) {
        return line;
      }

      return line.replaceRange(
        0,
        0,
        '$sequence ',
      );
    });
  }

  void _uncommentSelectedLines() {
    modifySelectedLines((line) {
      if (line.hasOnlyWhitespaces()) {
        return line;
      }

      for (final sequence
          in SingleLineComments.byMode[language] ?? <String>[]) {
        // If there is a space after a sequence
        // we should remove it with the sequence.
        if (line.trim().startsWith('$sequence ')) {
          return line.replaceFirst('$sequence ', '');
        }
        // If there is no space after a sequence
        // we should remove the sequence.
        if (line.trim().startsWith(sequence)) {
          return line.replaceFirst(sequence, '');
        }
      }

      // If line is not commented just return it.
      return line;
    });
  }

  /// Filters the lines that have at least one character selected.
  ///
  /// IMPORTANT: this method also changes the selection to be:
  /// start: start of the first selected line
  /// end: end of the last line
  ///
  /// Folded blocks are considered to be selected
  /// if they are located between start and end of a selection.
  ///
  /// [modifierCallback] - transformation function that modifies the line.
  /// `line` in the callback contains '\n' symbol at the end, except for the last line of the document.
  // TODO(yescorp): need to preserve folding..
  void modifySelectedLines(
    String Function(String line) modifierCallback,
  ) {
    if (readOnly) {
      return;
    }

    if (selection.start == -1 || selection.end == -1) {
      return;
    }

    final lineRange = getSelectedLineRange();

    // Apply modification to the selected lines.
    final modifiedLinesBuffer = StringBuffer();
    for (int i = lineRange.start; i < lineRange.end; i++) {
      // Cancel modification entirely if any of the lines is readOnly.
      if (_code.lines.lines[i].isReadOnly) {
        return;
      }
      final modifiedString = modifierCallback(_code.lines.lines[i].text);
      modifiedLinesBuffer.write(modifiedString);
    }

    final modifiedLinesString = modifiedLinesBuffer.toString();

    final firstLineStart = _code.lines.lines[lineRange.start].textRange.start;
    final lastLineEnd = _code.lines.lines[lineRange.end - 1].textRange.end;

    // Replace selected lines with modified ones.
    final finalFullText = _code.text.replaceRange(
      firstLineStart,
      lastLineEnd,
      modifiedLinesString,
    );

    _updateCodeIfChanged(finalFullText);

    final finalFullSelection = TextSelection(
      baseOffset: firstLineStart,
      extentOffset: firstLineStart + modifiedLinesString.length,
    );
    final finalVisibleSelection =
        _code.hiddenRanges.cutSelection(finalFullSelection);

    super.value = TextEditingValue(
      text: _code.visibleText,
      selection: finalVisibleSelection,
    );
  }

  TextRange getSelectedLineRange() {
    final firstChar = _code.hiddenRanges.recoverPosition(
      selection.start,
      placeHiddenRanges: TextAffinity.downstream,
    );
    final lastChar = _code.hiddenRanges.recoverPosition(
      // To avoid including the next line if `\n` is selected.
      selection.isCollapsed ? selection.end : selection.end - 1,
      placeHiddenRanges: TextAffinity.downstream,
    );

    final firstLineIndex = _code.lines.characterIndexToLineIndex(firstChar);
    final lastLineIndex = _code.lines.characterIndexToLineIndex(lastChar);

    return TextRange(
      start: firstLineIndex,
      end: lastLineIndex + 1,
    );
  }

  Code get code => _code;

  CodeEditResult? _getEditResultNotBreakingReadOnly(TextEditingValue newValue) {
    if (readOnly) {
      return null;
    }

    final editResult = _code.getEditResult(value.selection, newValue);
    if (!_code.isReadOnlyInLineRange(editResult.linesChanged)) {
      return editResult;
    }

    return null;
  }

  void _updateCodeIfChanged(String text) {
    if (text != _code.text) {
      _updateCode(text);
    }
  }

  void _updateCode(String text) {
    final newCode = _createCode(text);
    _code = newCode.foldedAs(_code);
  }

  Code _createCode(String text) {
    return Code(
      text: text,
      language: language,
      highlighted: highlight.parse(text, language: _languageId),
      namedSectionParser: namedSectionParser,
      readOnlySectionNames: _readOnlySectionNames,
      visibleSectionNames: _visibleSectionNames,
    );
  }

  String _replaceTabsWithSpacesIfNeeded(String text) {
    if (modifiers.contains(const TabModifier())) {
      return text.replaceAll('\t', ' ' * params.tabSpaces);
    }
    return text;
  }

  void foldAt(int line) {
    final newCode = _code.foldedAt(line);
    super.value = _getValueWithCode(newCode);

    _code = newCode;
  }

  void unfoldAt(int line) {
    final newCode = _code.unfoldedAt(line);
    super.value = _getValueWithCode(newCode);

    _code = newCode;
  }

  Set<String> get readOnlySectionNames => _readOnlySectionNames;

  set readOnlySectionNames(Set<String> newValue) {
    _readOnlySectionNames = newValue;
    _updateCode(_code.text);

    notifyListeners();
  }

  Set<String> get visibleSectionNames => _visibleSectionNames;

  set visibleSectionNames(Set<String> sectionNames) {
    _visibleSectionNames = sectionNames;
    _updateCode(_code.text);

    super.value = _getValueWithCode(_code);
  }

  /// The value with [newCode] preserving the current selection.
  TextEditingValue _getValueWithCode(Code newCode) {
    return TextEditingValue(
      text: newCode.visibleText,
      selection: newCode.hiddenRanges.cutSelection(
        _code.hiddenRanges.recoverSelection(value.selection),
      ),
    );
  }

  void foldCommentAtLineZero() {
    final block = _code.foldableBlocks.firstOrNull;

    if (block == null || !block.isComment || block.firstLine != 0) {
      return;
    }

    foldAt(0);
  }

  void foldImports() {
    // TODO(alexeyinkin): An optimized method to fold multiple blocks, https://github.com/akvelon/flutter-code-editor/issues/106
    for (final block in _code.foldableBlocks) {
      if (block.isImports) {
        foldAt(block.firstLine);
      }
    }
  }

  /// Folds blocks that are outside all of the [names] sections.
  ///
  /// For a block to be not folded, it must overlap any of the given sections
  /// in any way.
  void foldOutsideSections(Iterable<String> names) {
    final foldLines = {..._code.foldableBlocks.map((b) => b.firstLine)};
    final sections = names.map((s) => _code.namedSections[s]).whereNotNull();

    for (final block in _code.foldableBlocks) {
      for (final section in sections) {
        if (block.overlaps(section)) {
          foldLines.remove(block.firstLine);
          break;
        }
      }
    }

    // TODO(alexeyinkin): An optimized method to fold multiple blocks, https://github.com/akvelon/flutter-code-editor/issues/106
    foldLines.forEach(foldAt);
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    bool? withComposing,
  }) {
    final spanBeforeSearch = _createTextSpan(
      context: context,
      style: style,
    );

    return spanBeforeSearch;
  }

  TextSpan _createTextSpan({
    required BuildContext context,
    TextStyle? style,
  }) {
    // Return parsing
    if (_language != null) {
      return SpanBuilder(
        code: _code,
        theme: _getTheme(context),
        rootStyle: style,
      ).build();
    }

    return TextSpan(text: text, style: style);
  }

  CodeThemeData _getTheme(BuildContext context) {
    return CodeTheme.of(context) ?? CodeThemeData();
  }

  void dismiss() {
    _dismissSuggestions();
  }

  void _dismissSuggestions() {}

  @override
  void dispose() {
    _debounce?.cancel();

    super.dispose();
  }
}
