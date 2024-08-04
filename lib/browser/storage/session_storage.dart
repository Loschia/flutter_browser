import 'dart:convert';

/// Manages temporary data stored in the browser's session storage, organized by website.
///
/// Data stored in session storage is cleared when the browser session ends
/// and should not be persisted across sessions.
class SessionStorage {
  /// Creates an empty `SessionStorage` object.
  ///
  /// - `initialData`: Optional initial data to populate the session storage.
  ///   If not provided, an empty session storage is created.
  ///   Note: It's generally not recommended to initialize session storage with
  ///   data, as it's meant for temporary data during a single session
  SessionStorage({Map<String, Map<String, dynamic>>? initialData}) : _data = initialData ?? {};

  final Map<String, Map<String, dynamic>> _data; // In-memory storage, organized by website

  /// Access the underlying data structure directly
  Map<String, Map<String, dynamic>> get data => _data;

  /// Creates a `SessionStorage` object from a JSON.
  ///
  /// Warning: This method is discouraged as session storage is meant for temporary data
  /// and should not be persisted or imported across sessions
  factory SessionStorage.fromJson(String json) => SessionStorage(initialData: jsonDecode(json) as Map<String, Map<String, dynamic>>);

  /// Converts the `SessionStorage` data to a JSON string.
  ///
  /// Warning: This method is discouraged as session storage is meant for temporary data
  /// and should not be persisted or exported across sessions
  String toJson() => jsonEncode(_data);

  /// Gets the value associated with the given `key` for the specified `website`.
  ///
  /// - `website`: The domain or origin of the website the data is associated with
  /// - `key`: The key to retrieve the value for.
  ///
  /// Returns `null` if the key does not exist for the given website.
  Future<dynamic> getItem(String website, String key) async => _data[website]?[key];

  /// Retrieves the storage data associated with the given `website`.
  ///
  /// - `website`: The domain or origin of the website to retrieve storage for.
  ///
  /// Returns a `Map<String, dynamic>` containing the key-value pairs stored for the website.
  /// If no data is found for the website, an empty map is returned.
  Future<dynamic> getWebSiteStorage(String website) async => _data[website] ?? {};

  /// Sets the `value` associated with the given `key` for the specified `website`.
  ///
  /// - `website`: The domain or origin of the website the data is associated with
  /// - `key`: The key to store the value under
  /// - `value`: The value to store, which can be any JSON-serializable type
  Future<void> setItem(String website, String key, dynamic value) async {
    _data[website] ??= {};
    _data[website]![key] = value;
    _notifyChange();
  }

  /// Removes the item with the given `key` for the specified `website` from session storage
  ///
  /// - `website`: The domain or origin of the website the data is associated with
  /// - `key`: The key of the item to remove
  Future<void> removeItem(String website, String key) async {
    _data[website]?.remove(key);
    _notifyChange();

    if (_data[website] == {}) _data.remove(website);
  }

  /// Clears all data from session storage for all websites
  Future<void> clear() async {
    _data.clear();
    _notifyChange();
    // TODO: Clear all data from the browser's session storage
  }

  /// Notifies other parts of the application about changes to session storage
  void _notifyChange() {
    // TODO: Implement notification logic
    print('Session storage changed');
  }

  @override
  String toString() => _data.toString();
}
