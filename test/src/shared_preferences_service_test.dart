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

    test('can set string', () async {
      arrangeSetStringResponse(response: true);

      await sut.setString(key: 'key', value: 'value');

      verify(() => sharedPreferences.setString(any(), any())).called(1);
    });

    test('can throw SetValueException when can not set string', () {
      arrangeSetStringResponse(response: false);

      expect(
        sut.setString(key: 'key', value: 'value'),
        throwsA(isA<SetValueException>()),
      );
    });

    test('can set list of string', () async {
      arrangeSetStringListResponse(response: true);

      await sut.setStringList(key: 'key', value: []);

      verify(() => sharedPreferences.setStringList(any(), any())).called(1);
    });

    test('can throw SetValueException when can not set list of string', () {
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
        'can throw UnexpectedValueTypeException when the value type is '
        'unexpected.', () async {
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
  });
}
