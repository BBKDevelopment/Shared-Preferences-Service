// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_service/shared_preferences_service.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('SharedPreferencesService', () {
    test('can be instantiated', () async {
      expect(
        SharedPreferencesService(sharedPreferences: MockSharedPreferences()),
        isNotNull,
      );
    });
  });
}
