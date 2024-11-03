import 'dart:convert';

/// Manages persistent or temporary data stored in the browser's local storage, organized by website.
///
/// Note: You are responsible for manually persisting the data using the `toJson` method.
class Storage {
  /// Creates a `Storage` object.
  ///
  /// - `initialData`: Optional initial data to populate the storage.
  ///   If not provided, an empty storage is created.
  ///   You can also use the `fromJson` constructor to initialize from a JSON string.
  /// Note: It's generally not recommended to initialize session storage with data, as it's meant for temporary data during a single session
  Storage({Map<String, Map<String, dynamic>>? initialData}) : _data = initialData ?? {};

  final Map<String, Map<String, dynamic>> _data; // In-memory storage, organized by website

  /// Access the underlying data structure directly
  Map<String, Map<String, dynamic>> get data => _data;

  /// Creates a `Storage` object from a JSON-serializable map.
  /// Warning: This method is discouraged for a session storage. It is meant for temporary data and should not be persisted or imported across sessions
  factory Storage.fromJson(String json) => Storage(initialData: jsonDecode(json) as Map<String, Map<String, dynamic>>);

  /// Converts the `Storage` data to a JSON string for persistence.
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
    _data[website] ??= {}; // Initialize data for the website if it doesn't exist
    _data[website]![key] = value;
    _notifyChange();
  }

  /// Removes the item with the given `key` for the specified `website` from local storage
  ///
  /// - `website`: The domain or origin of the website the data is associated with
  /// - `key`: The key of the item to remove
  Future<void> removeItem(String website, String key) async {
    _data[website]?.remove(key);
    _notifyChange();

    if (_data[website] == {}) _data.remove(website);
  }

  /// Clears all data from local storage for all websites.
  Future<void> clear() async {
    _data.clear();
    _notifyChange();
  }

  /// Notifies other parts of the application about changes to local storage
  void _notifyChange() {
    // TODO: Implement notification logic
    print('Storage changed');
  }

  @override
  String toString() => _data.toString();
}
