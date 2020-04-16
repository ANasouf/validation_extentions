
```dart
Form(
      key: _formKey,
      child: TextFormField(
          validator: (v) => v.isRequired()(),
        ),
      ),
```

More examples can be found in tests file.