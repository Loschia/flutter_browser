import 'dart:convert';

import 'package:flutter_browser/browser/storage/index.dart';

/// Manages the complete browser storage, encompassing cookies,
/// local storage, and session storage.
class StorageManager {
  /// Constructs a `Storage` object, allowing for optional initialization
  /// of its components: `cookieManager`, `localStorage`, and `sessionStorage`.
  /// If any of these components are not provided, default empty instances are created.
  StorageManager({
    CookieManager? cookieManager,
    Storage? localStorage,
    Storage? sessionStorage,
  })  : cookies = cookieManager ?? CookieManager(),
        localStorage = localStorage ?? Storage(),
        sessionStorage = sessionStorage ?? Storage();

  /// Manages the browser's HTTP cookies.
  CookieManager cookies;

  /// Handles persistent data storage using the browser's local storage mechanism.
  Storage localStorage;

  /// Manages temporary data storage within the current browser session.
  Storage sessionStorage;

  // Internal keys used for JSON serialization and deserialization
  static const _cookiesString = 'cookies';
  static const _localStorageString = 'local_storage';
  static const _sessionStorageString = 'session_storage';

  /// Factory constructor to create a `Storage` object from a JSON string.
  ///
  /// This method deserializes the JSON data and creates the corresponding
  /// `CookieManager`, `LocalStorage`, and `SessionStorage` objects.
  factory StorageManager.fromJson(String json) {
    final Map<String, dynamic> jsonData = jsonDecode(json);
    return StorageManager(
      cookieManager: CookieManager.fromJson(jsonData[_cookiesString].cast<Map<String, dynamic>>()),
      localStorage: Storage.fromJson(jsonData[_localStorageString].cast<String, Map<String, dynamic>>()),
      sessionStorage: Storage.fromJson(jsonData[_sessionStorageString].cast<String, Map<String, dynamic>>()),
    );
  }

  /// Serializes the `Storage` object into a JSON string.
  ///
  /// This method converts the internal data structures of `cookies` and `localStorage`
  /// into a JSON representation for easy persistence or transmission.
  ///
  /// - `exportSessionStorage`: If `true`, also includes `sessionStorage` data in the JSON output.
  ///   Defaults to `false` as session storage is typically not persisted.
  String toJson({bool exportSessionStorage = false}) => jsonEncode({
        _cookiesString: cookies.toJson(),
        _localStorageString: localStorage.toJson(),
        if (exportSessionStorage) _sessionStorageString: sessionStorage.toJson(),
      });
}
