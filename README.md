
# validation_extensions

Flutter form field validations using dart extension methods.
## Available validation extension methods

### String extension methods

Check tests file for examples on how to use them.
|Method|Parameters | Description |
|--|--|--|
| isRequired | None| Validates if the string in not empty|
| isEmail | None |Validates if the string is a valid email address|
| minLength | int min |Validates if the string length is longer than min|
| maxLength | int max |Validates if the string length is shorter than max|
| lengthRange | int min, int max |Validates if the string length is longer than min and shorter than max|
| match | String stringToMatch |Validates if the string is an exact match of the String stringToMatch parameter that you provide|
| matchPattern | String regExp |Validates if the string matches the regular expression regExp parameter that you provide|
| isInt | None |Validates if the string is a valid integer|
| isDouble |None  |Validates if the string is a valid double|
| min | int min |Validates if the string is a valid double bigger than min|
| max | int max |Validates if the string is a valid double smaller than max|
| range | int min, int max |Validates if the string is a valid double between min and max|

### List\<Function> extension methods

|Method| Description |
|--|--|
| validate | execute validation functions one by one, will stop execution when it encounter a validation error and return the errorText  |

## Usage

All extension methods return type is Function, you have to use double parentheses to execute the returned function for single validations.

```dart
Form(
      key: _formKey,
      child: TextFormField(
          validator: (v) => v.isRequired()(),
        ),
      ),
```

## Multi validations

For multi rules validation put your validation in a list and call validate() extension method on the list, it will execute validation one by one, it will stop execution when it encounter the first validation error and return the errorText to increase performance.

```dart
Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            onChanged: (v) => password = v,
            validator: (v) => [
              v.isRequired(),
              v.minLength(8),
            ].validate(),
          ),
          TextFormField(
            validator: (v) => [
              v.isRequired(),
              v.match(password),
            ].validate(),
          ),
        ],
      ),
    ),
```

## Custom validations

If you want to use you own validations in multi rule validation, your validation rules must be:
Function that returns a Function that returns a String.

```dart
Function customValidation(v) {
	return(){
			return v != "Validation logic" ? "Invalid input" : null;
	};
}

Form(
     key: _formKey,
     child: TextFormField(
        autovalidate: true,
        validator: (v) => [
			v.isRequired(),
	        customValidation(v),
        ].validate(),
      ),
    ),
```
## Custom error message

Pass the optional named parameter *errorText* to the extension method to override the default error message

```dart
Form(
      key: _formKey,
      child: TextFormField(
        onChanged: (v) => password = v,
        validator: (v) => [
          v.isRequired(
            errorText: "Password is required",
          ),
          v.minLength(
            8,
            errorText: "Password can not be less than 8 characters",
          ),
        ].validate(),
      ),
    ),

```