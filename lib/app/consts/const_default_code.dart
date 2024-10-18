const defaultCode =
    '''const dispatch = pluckDeep(var key) => (Map<String, dynamic> obj) {
    return key.split('.').fold(obj, (var accum,final key) => accum[key]);
  };
  
Function compose(List<Function> fns) {
  return (var res) {
    return fns.fold(res, (accum, next) => next(accum));
  };
}''';

const githuburl="https://github.com/IldySilva/SnapInk";