import 'package:flutter_test/flutter_test.dart';

import 'package:validation_extensions/validation_extensions.dart';

void main() {
  test('Required field', () {
    String testString = "testString";
    expect(testString.isRequired()(), null);
    expect(testString.isRequired(errorText: "errorText message")(), null);
    expect(
        "".isRequired(errorText: "errorText message")(), "errorText message");
  });
  test('Minimum string length', () {
    final testString = "testString";
    expect(testString.minLength(5)(), null);
    expect(testString.minLength(11, errorText: "errorText message")(),
        "errorText message");
  });
  test('Maximum string length', () {
    final testString = "testString";
    expect(testString.maxLength(11, errorText: "errorText message")(), null);
    expect(testString.maxLength(5, errorText: "errorText message")(),
        "errorText message");
  });
  test('String length range', () {
    final testString = "testString";
    expect(
        testString.lengthRange(3, 15, errorText: "errorText message")(), null);
    expect(testString.lengthRange(11, 20, errorText: "errorText message")(),
        "errorText message");
    expect(testString.lengthRange(1, 5, errorText: "errorText message")(),
        "errorText message");
  });
  test('String match', () {
    final testString = "testString";
    expect(
        testString.match("testString", errorText: "errorText message")(), null);
    expect(testString.match("", errorText: "errorText message")(),
        "errorText message");
    expect(testString.match("TestString", errorText: "errorText message")(),
        "errorText message");
    expect(testString.match("testString2", errorText: "errorText message")(),
        "errorText message");
    expect(testString.match("_testString", errorText: "errorText message")(),
        "errorText message");
  });
  test('Pattern match', () {
    final testString = "testString";
    expect(testString.matchPattern("^test", errorText: "errorText message")(),
        null);
    expect(
        testString.matchPattern(".*", errorText: "errorText message")(), null);
    expect(
        testString.matchPattern("g\$", errorText: "errorText message")(), null);
    expect(testString.matchPattern("", errorText: "errorText message")(), null);
    expect(testString.matchPattern("ts", errorText: "errorText message")(),
        "errorText message");
  });
  test('Input is an integer', () {
    expect("0".isInt(errorText: "errorText message")(), null);
    expect("5".isInt(errorText: "errorText message")(), null);
    expect("-5".isInt(errorText: "errorText message")(), null);
    expect("1.5".isInt(errorText: "errorText message")(), "errorText message");
    expect("-1.5".isInt(errorText: "errorText message")(), "errorText message");
    expect(
        "integer".isInt(errorText: "errorText message")(), "errorText message");
    expect("1 integer".isInt(errorText: "errorText message")(),
        "errorText message");
    expect("1integer".isInt(errorText: "errorText message")(),
        "errorText message");
    expect("integer 2".isInt(errorText: "errorText message")(),
        "errorText message");
    expect("integer2".isInt(errorText: "errorText message")(),
        "errorText message");
  });
  test('Input is double', () {
    expect("0".isDouble(errorText: "errorText message")(), null);
    expect("5".isDouble(errorText: "errorText message")(), null);
    expect("-5".isDouble(errorText: "errorText message")(), null);
    expect("1.5".isDouble(errorText: "errorText message")(), null);
    expect("-1.5".isDouble(errorText: "errorText message")(), null);
    expect("double".isDouble(errorText: "errorText message")(),
        "errorText message");
    expect("1 double".isDouble(errorText: "errorText message")(),
        "errorText message");
    expect("1double".isDouble(errorText: "errorText message")(),
        "errorText message");
    expect("double 2".isDouble(errorText: "errorText message")(),
        "errorText message");
    expect("double2".isDouble(errorText: "errorText message")(),
        "errorText message");
  });
  test('Minimum input number', () {
    expect("0".min(0, errorText: "errorText message")(), null);
    expect("11".min(10, errorText: "errorText message")(), null);
    expect("2".min(3, errorText: "errorText message")(), "errorText message");
    expect("".min(10, errorText: "errorText message")(), "errorText message");
    expect("double".min(10, errorText: "errorText message")(),
        "errorText message");
  });
  test('Maximum input number', () {
    expect("0".max(0, errorText: "errorText message")(), null);
    expect("2".max(3, errorText: "errorText message")(), null);
    expect("3.5".max(3, errorText: "errorText message")(), "errorText message");
    expect("11".max(10, errorText: "errorText message")(), "errorText message");
    expect("".max(10, errorText: "errorText message")(), "errorText message");
    expect("double".max(10, errorText: "errorText message")(),
        "errorText message");
  });
  test('Email verification', () {
    expect("abc@gmail.com".isEmail(errorText: "errorText message")(), null);
    expect("12@cd.io".isEmail(errorText: "errorText message")(), null);
    expect(
        "email".isEmail(errorText: "errorText message")(), "errorText message");
    expect("a.b.c@d.c".isEmail(errorText: "errorText message")(), null);
    expect(
        "a@b".isEmail(errorText: "errorText message")(), "errorText message");
    expect("@yahoo.com".isEmail(errorText: "errorText message")(),
        "errorText message");
  });

  test('Multivalidation', () {
    String testString = "testString";
    expect([testString.isRequired(),testString.minLength(5)].validate(), null);
    // Both String invalid only first will excute better for performance
    expect(["".isRequired(errorText: "First error"),"".minLength(5, errorText: "Second error")].validate(), "First error");
    expect(["required".isRequired(errorText: "First error"),"".minLength(5, errorText: "Second error")].validate(), "Second error");
  });
}
