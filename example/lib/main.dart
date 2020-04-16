import 'package:flutter/material.dart';
import 'package:validation_extensions/validation_extensions.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "validation_extensions demo",
      home: DemoForm(),
    );
  }
}

class DemoForm extends StatefulWidget {
  @override
  _DemoFormState createState() => _DemoFormState();
}

class _DemoFormState extends State<DemoForm> {
  final _formKey = GlobalKey<FormState>();

  String password;

  String usernameValidation(String v) => v.isRequired()();

  String emailValidation(String v) => [v.isRequired(), v.isEmail()].validate();

  String ageValidation(String v) =>
      v.min(18, errorText: "You must be older than 18")();

  String passwordValidation(String v) => [
        v.isRequired(),
        v.minLength(8),
      ].validate();

  String confirmPasswordValidation(String v) => [
        v.isRequired(),
        v.minLength(8),
        v.match(password),
      ].validate();

  validate() {
    _formKey.currentState.validate();
  }

  resetForm() {
    _formKey.currentState.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: usernameValidation,
                  decoration: InputDecoration(
                    labelText: "Username*",
                  ),
                ),
                TextFormField(
                  validator: emailValidation,
                  decoration: InputDecoration(
                    labelText: "Email address*",
                  ),
                ),
                TextFormField(
                  validator: ageValidation,
                  decoration: InputDecoration(
                      labelText: "Age", hintText: "Optional age"),
                ),
                TextFormField(
                  validator: passwordValidation,
                  obscureText: true,
                  onChanged: (v) => password = v,
                  decoration: InputDecoration(
                    labelText: "Password*",
                  ),
                ),
                TextFormField(
                  validator: confirmPasswordValidation,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm password*",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        color: Colors.lightBlue,
                        onPressed: validate,
                        child: Text("Validate"),
                      ),
                      RaisedButton(
                        color: Colors.redAccent,
                        onPressed: resetForm,
                        child: Text("Reset form"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
