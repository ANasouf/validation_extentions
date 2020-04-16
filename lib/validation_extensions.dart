library validationextensions;

var emailRegExp =
    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
extension MultiValidations on List<Function> {
  String validate() {
    String errorText;
    for (int i = 0; i < this.length; i++) {
      errorText = this[i]();
      if (errorText != null) {
        break;
      }
    }
    return errorText;
  }
}

extension Validations on String {
  Function isRequired({String errorText}) =>
      () => this.isEmpty || this == null ? errorText ?? "Required field" : null;

  Function isEmail({String errorText}) =>
      () => !RegExp(emailRegExp).hasMatch(this)
          ? errorText ?? "invalid Email address"
          : null;

  Function minLength(int min, {String errorText}) => () => this.length < min
      ? errorText ?? "minimum length is $min characters"
      : null;

  Function maxLength(int max, {String errorText}) => () => this.length > max
      ? errorText ?? "maximum length is $max characters"
      : null;

  Function lengthRange(int min, int max, {String errorText}) =>
      () => this.length < min || this.length > max
          ? errorText ?? "length must be between $min & $max characters"
          : null;

  Function match(String stringToMatch, {String errorText}) =>
      () => !RegExp("^$stringToMatch\$", caseSensitive: true).hasMatch(this)
          ? errorText ?? "Values doesn't match"
          : null;

  Function matchPattern(String regExp, {String errorText}) =>
      () => !RegExp("$regExp").hasMatch(this)
          ? errorText ?? "Pattern doesn't match"
          : null;

  Function isInt({String errorText}) =>
      () => int.tryParse(this) == null ? errorText ?? "invalid number" : null;

  Function isDouble({String errorText}) => () =>
      double.tryParse(this) == null ? errorText ?? "invalid number" : null;

  Function min(int min, {String errorText}) =>
      () => double.tryParse(this) == null || double.parse(this) < min
          ? errorText ?? "Number must be bigger than $min"
          : null;

  Function max(int max, {String errorText}) =>
      () => double.tryParse(this) == null || double.parse(this) > max
          ? errorText ?? "Number must be smaller than $max"
          : null;

  Function range(int min, int max, {String errorText}) =>
      () => double.tryParse(this) == null &&
              double.parse(this) < min &&
              double.parse(this) > max
          ? errorText ?? "Number must be between $min & $max"
          : null;
}
