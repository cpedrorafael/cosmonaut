import 'package:flutter_test/flutter_test.dart';
import 'package:cosmonaut/core/extensions/string_extensions.dart';

void main() {
  var inputString = '2021-05-21T20:05:04.000Z';
  test('should get DateTime from String', () {
    var result = inputString.getDate();

    expect(result, isA<DateTime>());
  });

  test('should get null from invalid String', () {
    var result = 'test'.getDate();

    expect(result, null);
  });

  test('should get only date from String', () {
    var result = inputString.getDate(false);

    expect(result, isA<DateTime>());
    expect(result, DateTime(2021, 05, 21));
  });

  test('should get formatted date from String', () {
    var result = inputString.getFormattedDateString();

    expect(result, isA<String>());
    expect(result, 'May 21, 2021');
  });

  test('should get empty String when date formatting invalid String', () {
    var result = 'test'.getFormattedDateString();

    expect(result, isA<String>());
    expect(result, '');
  });
}
