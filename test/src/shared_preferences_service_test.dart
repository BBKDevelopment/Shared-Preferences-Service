// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_service/shared_preferences_service.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferencesService sut;
  late SharedPreferences sharedPreferences;

  setUpAll(() {
    sharedPreferences = MockSharedPreferences();
    sut = SharedPreferencesService(sharedPreferences: sharedPreferences);
  });

  void arrangeSetBoolResponse({required bool response}) {
    when(() => sharedPreferences.setBool(any(), any()))
        .thenAnswer((_) async => response);
  }

  void arrangeSetDoubleResponse({required bool response}) {
    when(() => sharedPreferences.setDouble(any(), any()))
        .thenAnswer((_) async => response);
  }

  void arrangeSetIntResponse({required bool response}) {
    when(() => sharedPreferences.setInt(any(), any()))
        .thenAnswer((_) async => response);
  }

  void arrangeSetStringResponse({required bool response}) {
    when(() => sharedPreferences.setString(any(), any()))
        .thenAnswer((_) async => response);
  }

  void arrangeSetStringListResponse({required bool response}) {
    when(() => sharedPreferences.setStringList(any(), any()))
        .thenAnswer((_) async => response);
  }

  void arrangeGetResponse({required Object? response}) {
    when(() => sharedPreferences.get(any())).thenAnswer((_) => response);
  }

  void arrangeGetBoolResponse({
    bool? response,
    bool throwException = false,
  }) {
    if (throwException) {
      when(() => sharedPreferences.getBool(any())).thenThrow(Exception());
      return;
    }

    when(() => sharedPreferences.getBool(any())).thenAnswer((_) => response);
  }

  void arrangeGetDoubleResponse({
    double? response,
    bool throwException = false,
  }) {
    if (throwException) {
      when(() => sharedPreferences.getDouble(any())).thenThrow(Exception());
      return;
    }

    when(() => sharedPreferences.getDouble(any())).thenAnswer((_) => response);
  }

  void arrangeGetIntResponse({
    int? response,
    bool throwException = false,
  }) {
    if (throwException) {
      when(() => sharedPreferences.getInt(any())).thenThrow(Exception());
      return;
    }

    when(() => sharedPreferences.getInt(any())).thenAnswer((_) => response);
  }

  void arrangeGetKeysResponse({required Set<String> response}) {
    when(() => sharedPreferences.getKeys()).thenAnswer((_) => response);
  }

  void arrangeGetStringResponse({
    String? response,
    bool throwException = false,
  }) {
    if (throwException) {
      when(() => sharedPreferences.getString(any())).thenThrow(Exception());
      return;
    }

    when(() => sharedPreferences.getString(any())).thenAnswer((_) => response);
  }

  void arrangeGetStringListResponse({
    List<String>? response,
    bool throwException = false,
  }) {
    if (throwException) {
      when(() => sharedPreferences.getStringList(any())).thenThrow(Exception());
      return;
    }

    when(() => sharedPreferences.getStringList(any()))
        .thenAnswer((_) => response);
  }

  group('SharedPreferencesService', () {
    test('can be instantiated', () {
      expect(
        SharedPreferencesService(sharedPreferences: sharedPreferences),
        isNotNull,
      );
    });

    test('can set bool', () async {
      arrangeSetBoolResponse(response: true);

      await sut.setBool(key: 'key', value: true);

      verify(() => sharedPreferences.setBool(any(), any())).called(1);
    });

    test('can throw SetValueException when can not set bool', () {
      arrangeSetBoolResponse(response: false);

      expect(
        sut.setBool(key: 'key', value: true),
        throwsA(isA<SetValueException>()),
      );
    });

    test('can set double', () async {
      arrangeSetDoubleResponse(response: true);

      await sut.setDouble(key: 'key', value: 0);

      verify(() => sharedPreferences.setDouble(any(), any())).called(1);
    });

    test('can throw SetValueException when can not set double', () {
      arrangeSetDoubleResponse(response: false);

      expect(
        sut.setDouble(key: 'key', value: 0),
        throwsA(isA<SetValueException>()),
      );
    });

    test('can set int', () async {
      arrangeSetIntResponse(response: true);

      await sut.setInt(key: 'key', value: 0);

      verify(() => sharedPreferences.setInt(any(), any())).called(1);
    });

    test('can throw SetValueException when can not set int', () {
      arrangeSetIntResponse(response: false);

      expect(
        sut.setInt(key: 'key', value: 0),
        throwsA(isA<SetValueException>()),
      );
    });

    test('can set String', () async {
      arrangeSetStringResponse(response: true);

      await sut.setString(key: 'key', value: 'value');

      verify(() => sharedPreferences.setString(any(), any())).called(1);
    });

    test('can throw SetValueException when can not set String', () {
      arrangeSetStringResponse(response: false);

      expect(
        sut.setString(key: 'key', value: 'value'),
        throwsA(isA<SetValueException>()),
      );
    });

    test('can set List<String>', () async {
      arrangeSetStringListResponse(response: true);

      await sut.setStringList(key: 'key', value: []);

      verify(() => sharedPreferences.setStringList(any(), any())).called(1);
    });

    test('can throw SetValueException when can not set List<String>', () {
      arrangeSetStringListResponse(response: false);

      expect(
        sut.setStringList(key: 'key', value: []),
        throwsA(isA<SetValueException>()),
      );
    });

    test('can get', () {
      arrangeGetResponse(response: true);

      expect(sut.get(key: 'key'), true);
    });

    test(
        'can throw KeyNotFoundException when can not get any value with the '
        'given key', () {
      arrangeGetResponse(response: null);

      expect(
        () => sut.get(key: 'key'),
        throwsA(isA<KeyNotFoundException>()),
      );
    });

    test('can get bool', () async {
      arrangeGetBoolResponse(response: true);

      sut.getBool(key: 'key');

      verify(() => sharedPreferences.getBool(any())).called(1);
    });

    test(
        'can throw UnexpectedValueTypeException when the value type is not '
        'bool', () async {
      arrangeGetBoolResponse(throwException: true);

      expect(
        () => sut.getBool(key: 'key'),
        throwsA(isA<UnexpectedValueTypeException>()),
      );
    });

    test(
        'can throw KeyNotFoundException when can not get any bool with the '
        'given key', () async {
      arrangeGetBoolResponse();

      expect(
        () => sut.getBool(key: 'key'),
        throwsA(isA<KeyNotFoundException>()),
      );
    });

    test('can get double', () async {
      arrangeGetDoubleResponse(response: 0);

      sut.getDouble(key: 'key');

      verify(() => sharedPreferences.getDouble(any())).called(1);
    });

    test(
        'can throw UnexpectedValueTypeException when the value type is not '
        'double', () async {
      arrangeGetDoubleResponse(throwException: true);

      expect(
        () => sut.getDouble(key: 'key'),
        throwsA(isA<UnexpectedValueTypeException>()),
      );
    });

    test(
        'can throw KeyNotFoundException when can not get any double with the '
        'given key', () async {
      arrangeGetDoubleResponse();

      expect(
        () => sut.getDouble(key: 'key'),
        throwsA(isA<KeyNotFoundException>()),
      );
    });

    test('can get int', () async {
      arrangeGetIntResponse(response: 0);

      sut.getInt(key: 'key');

      verify(() => sharedPreferences.getInt(any())).called(1);
    });

    test(
        'can throw UnexpectedValueTypeException when the value type is not '
        'int', () async {
      arrangeGetIntResponse(throwException: true);

      expect(
        () => sut.getInt(key: 'key'),
        throwsA(isA<UnexpectedValueTypeException>()),
      );
    });

    test(
        'can throw KeyNotFoundException when can not get any int with the '
        'given key', () async {
      arrangeGetIntResponse();

      expect(
        () => sut.getInt(key: 'key'),
        throwsA(isA<KeyNotFoundException>()),
      );
    });

    test('can get keys', () async {
      arrangeGetKeysResponse(response: {'key'});

      sut.getKeys();

      verify(() => sharedPreferences.getKeys()).called(1);
    });

    test('can throw NoKeysAvailableException when there is no key available',
        () async {
      arrangeGetKeysResponse(response: {});

      expect(
        () => sut.getKeys(),
        throwsA(isA<NoKeysAvailableException>()),
      );
    });

    test('can get String', () async {
      arrangeGetStringResponse(response: 'value');

      sut.getString(key: 'key');

      verify(() => sharedPreferences.getString(any())).called(1);
    });

    test(
        'can throw UnexpectedValueTypeException when the value type is not '
        'String', () async {
      arrangeGetStringResponse(throwException: true);

      expect(
        () => sut.getString(key: 'key'),
        throwsA(isA<UnexpectedValueTypeException>()),
      );
    });

    test(
        'can throw KeyNotFoundException when can not get any String with the '
        'given key', () async {
      arrangeGetStringResponse();

      expect(
        () => sut.getString(key: 'key'),
        throwsA(isA<KeyNotFoundException>()),
      );
    });

    test('can get List<String>', () async {
      arrangeGetStringListResponse(response: ['value']);

      sut.getStringList(key: 'key');

      verify(() => sharedPreferences.getStringList(any())).called(1);
    });

    test(
        'can throw UnexpectedValueTypeException when the value type is not '
        'List<String>', () async {
      arrangeGetStringListResponse(throwException: true);

      expect(
        () => sut.getStringList(key: 'key'),
        throwsA(isA<UnexpectedValueTypeException>()),
      );
    });

    test(
        'can throw KeyNotFoundException when can not get List<String> with the '
        'given key', () async {
      arrangeGetStringListResponse();

      expect(
        () => sut.getStringList(key: 'key'),
        throwsA(isA<KeyNotFoundException>()),
      );
    });
  });
}
