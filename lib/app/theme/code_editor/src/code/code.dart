import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import '../highlight/result.dart';
import '../../../language/src/mode.dart';
import '../../../language/src/result.dart';
import '../code_field/text_editing_value.dart';
import '../hidden_ranges/hidden_line_ranges.dart';
import '../hidden_ranges/hidden_line_ranges_builder.dart';
import '../hidden_ranges/hidden_range.dart';
import '../hidden_ranges/hidden_ranges.dart';
import '../hidden_ranges/hidden_ranges_builder.dart';
import '../named_sections/named_section.dart';
import '../named_sections/parsers/abstract.dart';
import '../single_line_comments/parser/single_line_comment_parser.dart';
import '../single_line_comments/parser/single_line_comments.dart';
import '../single_line_comments/single_line_comment.dart';
import 'code_edit_result.dart';
import 'code_line.dart';
import 'code_lines.dart';
import 'code_lines_builder.dart';
import 'map.dart';
import 'string.dart';
import 'text_range.dart';

class Code {
  final String text;
  final HiddenLineRanges hiddenLineRanges;
  final HiddenRanges hiddenRanges;
  final Result? highlighted;
  final CodeLines lines;
  final Map<String, NamedSection> namedSections;
  final Result? visibleHighlighted;
  final String visibleText;
  final Set<String> visibleSectionNames;

  final HiddenRangesBuilder _hiddenRangesBuilder;

  factory Code({
    required String text,
    Result? highlighted,
    Mode? language,
    AbstractNamedSectionParser? namedSectionParser,
    Set<String> readOnlySectionNames = const {},
    Set<String> visibleSectionNames = const {},
  }) {
    final sequences = SingleLineComments.byMode[language] ?? [];

    final commentParser = SingleLineCommentParser.parseHighlighted(
      text: text,
      highlighted: highlighted,
      singleLineCommentSequences: sequences,
    );



    final lines = CodeLinesBuilder.textToCodeLines(
      text: text,
      readonlyCommentsByLine: commentParser.getIfReadonlyCommentByLine(),
    );

    if (highlighted == null || language == null) {
    } else {

    }

    final sections = namedSectionParser?.parse(
          singleLineComments: commentParser.comments,
        ) ??
        const [];
    final sectionsMap = {for (final s in sections) s.name: s};

    final isCodeReadonly = visibleSectionNames.isNotEmpty;
    if (isCodeReadonly) {
      _makeCodeReadonly(lines: lines.lines);
    } else {
      _applyNamedSectionsToLines(
        lines: lines.lines,
        sections: sectionsMap,
        readOnlySectionNames: readOnlySectionNames,
      );
    }

    final visibleSectionsHiddenRanges = _visibleSectionsToHiddenRanges(
      visibleSectionNames,
      sectionsMap,
      lines,
    );

    final hiddenRangesBuilder = HiddenRangesBuilder.fromMaps(
      {
        String: visibleSectionsHiddenRanges,
      },
      textLength: text.length,
    );
    final hiddenRanges = hiddenRangesBuilder.ranges;

    final hiddenLineRangesBuilder = HiddenLineRangesBuilder(
      codeLines: lines,
      hiddenRanges: hiddenRanges,
    );

    return Code._(
      text: text,
      hiddenLineRanges: hiddenLineRangesBuilder.hiddenLineRanges,
      hiddenRanges: hiddenRanges,
      hiddenRangesBuilder: hiddenRangesBuilder,
      highlighted: highlighted,
      lines: lines,
      namedSections: sectionsMap,
      visibleHighlighted:
          hiddenRanges.cutHighlighted(highlighted)!.splitLines(),
      visibleText: hiddenRanges.cutString(text),
      visibleSectionNames: visibleSectionNames,
    );
  }

  const Code._({
    required this.text,
    required this.hiddenLineRanges,
    required this.hiddenRanges,
    required HiddenRangesBuilder hiddenRangesBuilder,
    required this.highlighted,
    required this.lines,
    required this.namedSections,
    required this.visibleHighlighted,
    required this.visibleText,
    required this.visibleSectionNames,
  }) : _hiddenRangesBuilder = hiddenRangesBuilder;

  static const empty = Code._(
    text: '',
    hiddenLineRanges: HiddenLineRanges.empty,
    hiddenRanges: HiddenRanges.empty,
    hiddenRangesBuilder: HiddenRangesBuilder.empty,
    highlighted: null,
    lines: CodeLines.empty,
    namedSections: {},
    visibleHighlighted: null,
    visibleText: '',
    visibleSectionNames: {},
  );

  static void _makeCodeReadonly({
    required List<CodeLine> lines,
  }) {
    for (int i = 0; i < lines.length; i++) {
      lines[i] = lines[i].copyWith(isReadOnly: true);
    }
  }

  static void _applyNamedSectionsToLines({
    required List<CodeLine> lines,
    required Map<String, NamedSection> sections,
    required Set<String> readOnlySectionNames,
  }) {
    for (final name in readOnlySectionNames) {
      final section = sections[name];

      if (section == null) {
        continue;
      }

      final lastLineIndex = section.lastLine ?? lines.length - 1;

      for (int i = section.firstLine; i <= lastLineIndex; i++) {
        lines[i] = lines[i].copyWith(isReadOnly: true);
      }
    }
  }

  ///Assumes that there is only one visible section.
  ///If there are more than one, the first one will be used,
  ///and the rest will be ignored.
  static Map<String, HiddenRange> _visibleSectionsToHiddenRanges(
    Set<String> names,
    Map<String, NamedSection> namedSections,
    CodeLines lines,
  ) {
    final section = namedSections.getByKeys(names).firstOrNull;

    final result = <String, HiddenRange>{};

    if (section == null) {
      if (lines.lines.last.textRange.end > 0 && names.isNotEmpty) {
        result['beginning'] = HiddenRange(
          0,
          lines.lines.last.textRange.end,
          firstLine: 0,
          lastLine: lines.lines.length - 1,
          wholeFirstLine: true,
        );
      }
      return result;
    }

    final startLine = lines.lines[section.firstLine];
    if (startLine.textRange.start > 0) {
      result['beginning'] = HiddenRange(
        0,
        startLine.textRange.start,
        firstLine: 0,
        lastLine: section.firstLine - 1,
        wholeFirstLine: true,
      );
    }
    final lastLine = section.lastLine;
    if (lastLine != null && lastLine < lines.lines.length - 1) {
      final start = lines.lines[lastLine].textRange.end;
      final end = lines.lines.last.textRange.end;

      // Can be equal if the last line has no \n.
      if (end > start) {
        result['ending'] = HiddenRange(
          start,
          end,
          firstLine: lastLine,
          lastLine: lines.lines.length - 1,
          wholeFirstLine: false,
        );
      }
    }
    return result;
  }



  /// Returns whether the current selection has any read-only part.
  bool isReadOnlySelected(TextRange range) {
    if (range.start == -1 && range.end == -1) {
      return false; // Empty selection.
    }

    final startChar = range.normalized.start;
    final endChar = range.normalized.end;

    return isReadOnlyInLineRange(
      TextRange(
        start: lines.characterIndexToLineIndex(startChar),
        end: lines.characterIndexToLineIndex(endChar),
      ),
    );
  }

  /// Returns whether any of the lines of this range is read-only.
  bool isReadOnlyInLineRange(TextRange lineRange) {
    for (int line = lineRange.start; line <= lineRange.end; line++) {
      if (lines.lines[line].isReadOnly) {
        return true;
      }
    }

    return false;
  }

  /// Returns the resulting full text if a given visible text edit is applied.
  ///
  /// The text in [visibleAfter] should be different from the [visibleText]
  /// otherwise the selected text is still considered to change.
  /// This is for the purpose of speed because this method is only supposed
  /// to be called during a change.
  ///
  /// [oldSelection] is the [TextSelection] before the edit.
  /// It is considered in a few special cases if the edit is around
  /// the selection. This is required to disambiguate
  /// edits that can otherwise lead to erroneous actions on hidden ranges.
  ///
  /// Outside of those special cases the [visibleAfter] is just diffed
  /// against [visibleText]. This changed region may be ambiguous.
  /// In this case the change is attributed upstream meaning the first
  /// possible region is considered to hold the change.
  CodeEditResult getEditResult(
    TextSelection oldSelection,
    TextEditingValue visibleAfter,
  ) {
    final visibleRangeAfter = visibleAfter.getChangedRange(
          TextEditingValue(text: visibleText, selection: oldSelection),
        ) ??
        visibleAfter.text.getChangedRange(
          visibleText,
          attributeChangeTo: TextAffinity.upstream,
        );

    if (visibleRangeAfter.start == -1 && visibleRangeAfter.end == -1) {
      return CodeEditResult(
        fullTextAfter: text,
        linesChanged: TextRange.empty,
      );
    }

    // Recover what exactly was the full old text that was replaced
    // with the new one. For this, inspect the start and end points
    // of the changed part in the old visibleText.
    // If any hidden ranges are collapsed at those points,
    // the trick is to correctly replace them or to correctly preserve them.
    final rangeBefore = TextRange(
      // `end` is responsible for deciding between these two cases when the user
      // entered some text at the point with a hidden range:
      //     text we are adding at the beginning of this line// [START section1]
      //     // [START section1]text we are adding at the beginning of this line
      // We do not want to add that text to the comment and its hidden range.
      // So we must place all hidden ranges collapsed at the end of the diff
      // *after* that diff:
      end: hiddenRanges.recoverPosition(
        visibleText.length - visibleAfter.text.length + visibleRangeAfter.end,
        placeHiddenRanges: TextAffinity.downstream,
      ),

      // If we are inserting (and the old changed part is empty),
      // then using the same `placeHiddenRanges` is straightforward.
      //
      // However, this is also the only option for a non-empty old changed range
      // with a hidden range collapsed at its start. Otherwise we would
      // append to that comment, and the new text will not be visible.
      // Using `TextAffinity.downstream` effectively deletes any such hidden
      // range because it falls into the range of replacement.
      // We may want to reconsider this if we support terminatable hidden range
      // comments like /* ... */ that do not acquire all text to the
      // end of the string.
      start: hiddenRanges.recoverPosition(
        visibleRangeAfter.start,
        placeHiddenRanges: TextAffinity.downstream,
      ),
    );

    final firstChangedLine = lines.characterIndexToLineIndex(rangeBefore.start);
    final lastChangedLine = lines.characterIndexToLineIndex(rangeBefore.end);

    // If there is any folded block that is going to be removed
    // because of `backspace` or `delete`, return unchanged text.
    if (oldSelection.isCollapsed &&
        visibleAfter.text.length == visibleText.length - 1) {
      return CodeEditResult(
        fullTextAfter: text,
        linesChanged: const TextRange(start: 0, end: 0),
      );
    }

    final fullTextAfter = rangeBefore.textBefore(text) +
        visibleRangeAfter.textInside(visibleAfter.text) +
        rangeBefore.textAfter(text);

    // The line at [start] has changed for sure.
    // The line at [end - 1] has changed if [end > start].
    // Additionally, the line at [end] has changed if two strings were glued:
    //  - (1) The last old char was '\n' AND
    //  - (2) The char before [start] is not '\n'.
    // We don't need to check (1) because otherwise [end] and [end - 1]
    // are on the same line.
    final lastChar = rangeBefore.end -
        ((rangeBefore.start == 0 || text[rangeBefore.start - 1] == '\n')
            ? 1
            : 0);

    final linesChanged = TextRange(
      start: lines.characterIndexToLineIndex(rangeBefore.start),
      end: lines.characterIndexToLineIndex(max(lastChar, rangeBefore.start)),
    );

    return CodeEditResult(
      fullTextAfter: fullTextAfter,
      linesChanged: linesChanged,
    );
  }










  Code _copyWithFolding({
    required HiddenRangesBuilder hiddenRangesBuilder,
  }) {
    final hiddenRanges = hiddenRangesBuilder.ranges;

    final hiddenLineRangesBuilder = HiddenLineRangesBuilder(
      codeLines: lines,
      hiddenRanges: hiddenRanges,
    );

    return Code._(
      text: text,
      hiddenLineRanges: hiddenLineRangesBuilder.hiddenLineRanges,
      hiddenRanges: hiddenRanges,
      hiddenRangesBuilder: hiddenRangesBuilder,
      highlighted: highlighted,
      lines: lines,
      namedSections: namedSections,
      visibleHighlighted:
          hiddenRanges.cutHighlighted(highlighted)?.splitLines(),
      visibleText: hiddenRanges.cutString(text),
      visibleSectionNames: visibleSectionNames,
    );
  }
}
