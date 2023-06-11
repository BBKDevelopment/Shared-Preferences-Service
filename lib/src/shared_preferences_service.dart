import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

/// An exception thrown when the key is not found.
class KeyNotFoundException implements Exception {}

/// An exception thrown when no keys are available.
class NoKeysAvailableException implements Exception {}

/// An exception thrown when the value could not be set.
class SetValueException implements Exception {}

/// An exception thrown when the value type is unexpected.
class UnexpectedValueTypeException implements Exception {}

/// {@template shared_preferences_service}
/// A service that provides shared preferences functionality.
///
/// This service is a wrapper around the [SharedPreferences] class.
///
/// ```dart
/// final sharedPreferences = await SharedPreferences.getInstance();
///
/// final sharedPreferencesService = SharedPreferencesService(
///  sharedPreferences: sharedPreferences,
/// );
/// ```
/// {@endtemplate}
class SharedPreferencesService {
  /// {@macro shared_preferences_service}
  const SharedPreferencesService({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  /// Sets the [value] for the given [key].
  ///
  /// Throws a [SetValueException] if the value could not be set.
  Future<void> setBool({
    required String key,
    required bool value,
  }) async {
    try {
      final isSuccess = await _sharedPreferences.setBool(key, value);

      if (!isSuccess) throw Exception();
    } catch (_) {
      log('Failed to set bool!', name: 'SharedPreferencesService');
      throw SetValueException();
    }
  }

  /// Sets the [value] for the given [key].
  ///
  /// Throws a [SetValueException] if the value could not be set.
  Future<void> setDouble({
    required String key,
    required double value,
  }) async {
    try {
      final isSuccess = await _sharedPreferences.setDouble(key, value);

      if (!isSuccess) throw Exception();
    } catch (_) {
      log('Failed to set double!', name: 'SharedPreferencesService');
      throw SetValueException();
    }
  }

  /// Sets the [value] for the given [key].
  ///
  /// Throws a [SetValueException] if the value could not be set.
  Future<void> setInt({
    required String key,
    required int value,
  }) async {
    try {
      final isSuccess = await _sharedPreferences.setInt(key, value);

      if (!isSuccess) throw Exception();
    } catch (_) {
      log('Failed to set int!', name: 'SharedPreferencesService');
      throw SetValueException();
    }
  }

  /// Sets the [value] for the given [key].
  ///
  /// Throws a [SetValueException] if the value could not be set.
  Future<void> setString({
    required String key,
    required String value,
  }) async {
    try {
      final isSuccess = await _sharedPreferences.setString(key, value);

      if (!isSuccess) throw Exception();
    } catch (_) {
      log('Failed to set string!', name: 'SharedPreferencesService');
      throw SetValueException();
    }
  }

  /// Sets the [value] for the given [key].
  ///
  /// Throws a [SetValueException] if the value could not be set.
  Future<void> setStringList({
    required String key,
    required List<String> value,
  }) async {
    try {
      final isSuccess = await _sharedPreferences.setStringList(key, value);

      if (!isSuccess) throw Exception();
    } catch (_) {
      log('Failed to set string list!', name: 'SharedPreferencesService');
      throw SetValueException();
    }
  }

  /// Returns the value for the given [key].
  ///
  /// Throws a [UnexpectedValueTypeException] if the value type is unexpected.
  ///
  /// Throws a [KeyNotFoundException] if the key is not found.
  Object get({required String key}) {
    final Object? response;
    try {
      response = _sharedPreferences.get(key);
    } catch (_) {
      log('Failed to get value!', name: 'SharedPreferencesService');
      throw UnexpectedValueTypeException();
    }

    if (response == null) {
      log('Key not found!', name: 'SharedPreferencesService');
      throw KeyNotFoundException();
    }

    return response;
  }

  /// Returns the value for the given [key].
  ///
  /// Throws a [UnexpectedValueTypeException] if the value type is unexpected.
  ///
  /// Throws a [KeyNotFoundException] if the key is not found.
  bool getBool({required String key}) {
    final bool? response;
    try {
      response = _sharedPreferences.getBool(key);
    } catch (_) {
      log('Failed to get bool!', name: 'SharedPreferencesService');
      throw UnexpectedValueTypeException();
    }

    if (response == null) {
      log('Key not found!', name: 'SharedPreferencesService');
      throw KeyNotFoundException();
    }

    return response;
  }

  /// Returns the value for the given [key].
  ///
  /// Throws a [UnexpectedValueTypeException] if the value type is unexpected.
  ///
  /// Throws a [KeyNotFoundException] if the key is not found.
  double getDouble({required String key}) {
    final double? response;
    try {
      response = _sharedPreferences.getDouble(key);
    } catch (_) {
      log('Failed to get double!', name: 'SharedPreferencesService');
      throw UnexpectedValueTypeException();
    }

    if (response == null) {
      log('Key not found!', name: 'SharedPreferencesService');
      throw KeyNotFoundException();
    }

    return response;
  }

  /// Returns the value for the given [key].
  ///
  /// Throws a [UnexpectedValueTypeException] if the value type is unexpected.
  ///
  /// Throws a [KeyNotFoundException] if the key is not found.
  int getInt({required String key}) {
    final int? response;
    try {
      response = _sharedPreferences.getInt(key);
    } catch (_) {
      log('Failed to get int!', name: 'SharedPreferencesService');
      throw UnexpectedValueTypeException();
    }

    if (response == null) {
      log('Key not found!', name: 'SharedPreferencesService');
      throw KeyNotFoundException();
    }

    return response;
  }

  /// Returns collection of all keys.
  ///
  /// Throws a [NoKeysAvailableException] if no keys are available.
  Set<String> getKeys() {
    final Set<String> response;
    try {
      response = _sharedPreferences.getKeys();

      if (response.isEmpty) throw Exception();
    } catch (_) {
      log('Failed to get keys!', name: 'SharedPreferencesService');
      throw NoKeysAvailableException();
    }

    return response;
  }

  /// Returns the value for the given [key].
  ///
  /// Throws a [UnexpectedValueTypeException] if the value type is unexpected.
  ///
  /// Throws a [KeyNotFoundException] if the key is not found.
  String getString({required String key}) {
    final String? response;
    try {
      response = _sharedPreferences.getString(key);
    } catch (_) {
      log('Failed to get string!', name: 'SharedPreferencesService');
      throw UnexpectedValueTypeException();
    }

    if (response == null) {
      log('Key not found!', name: 'SharedPreferencesService');
      throw KeyNotFoundException();
    }

    return response;
  }

  /// Returns the value for the given [key].
  ///
  /// Throws a [UnexpectedValueTypeException] if the value type is unexpected.
  ///
  /// Throws a [KeyNotFoundException] if the key is not found.
  List<String> getStringList({required String key}) {
    final List<String>? response;
    try {
      response = _sharedPreferences.getStringList(key);
    } catch (_) {
      log('Failed to get string list!', name: 'SharedPreferencesService');
      throw UnexpectedValueTypeException();
    }

    if (response == null) {
      log('Key not found!', name: 'SharedPreferencesService');
      throw KeyNotFoundException();
    }

    return response;
  }
}
