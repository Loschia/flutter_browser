import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_browser/browser/storage/index.dart';
import 'package:flutter_browser/browser/storage/storage.dart';

import 'components/browser_navigation_controller.dart';

/// Controls the navigation and actions of a web browser.
class BrowserController {
  /// Creates a `BrowserController` object with the specified `initialUrl` and an optional `storage` object.
  ///
  /// If `storage` is not provided, a new `Storage` object is created.
  BrowserController({required String initialUrl, Storage? storage})
      : _navigationController = BrowserNavigationController(initialUrl),
        _storage = storage ?? Storage();

  Storage _storage; // Storage object associated with this browser controller

  /// Gets the storage object associated with this browser controller
  Storage get storage => _storage;

  /// Sets the storage object for this browser controller
  set storage(Storage newStorage) {
    _storage = newStorage;
    // TODO: Notify listeners of storage change (if needed)
  }

  bool _isInitialized = false; // Flag to track initialization status

  /// Initializes the browser controller and its underlying web rendering engine.
  ///
  /// This method should be called before using any other methods of the controller.
  Future<void> initialize() async {
    if (_isInitialized) return; // Already initialized, do nothing

    if (kIsWeb && !kIsWasm) throw UnsupportedError('This application requires WebAssembly support.');

    // - If using WebAssembly + Blink, load and initialize the Blink module.
    // - If using CEF, initialize CEF components and load libraries.

    if (kIsWasm) await _initializeWasm();
    if (Platform.isWindows) await _initializeWindows();
    if (Platform.isMacOS) await _initializeMacOS();
    if (Platform.isAndroid) await _initializeAndroid();
    if (Platform.isIOS) await _initializeIOS();

    _isInitialized = true;
  }

  //TODO: initialize Wasm
  Future<void> _initializeWasm() async {}
  //TODO: initialize Windows
  Future<void> _initializeWindows() async {}
  //TODO: initialize Macos
  Future<void> _initializeMacOS() async {}
  //TODO: initialize Android
  Future<void> _initializeAndroid() async {}
  //TODO: initialize iOS
  Future<void> _initializeIOS() async {}
  final BrowserNavigationController _navigationController; // Private navigation controller instance

  /// Gets the URL of the currently displayed page.
  String get currentPage => _navigationController.currentPage;

  /// Checks if the browser can navigate back to a previous page.
  bool get canGoBack => _navigationController.canGoBack;

  /// Checks if the browser can navigate forward to a next page.
  bool get canGoForward => _navigationController.canGoForward;

  /// Checks if the browser is initialized.
  bool get isInitialized => _isInitialized;

  /// Navigates to the previous page in the history.
  ///
  /// Triggers a navigation event if successful.
  void goBack() {
    if (!_navigationController.goBack()) return;
    // TODO: Notify listeners of navigation change
  }

  /// Navigates to the next page in the history.
  ///
  /// Triggers a navigation event if successful.
  void goForward() {
    if (!_navigationController.goForward()) return;
    // TODO: Notify listeners of navigation change
  }

  /// Reloads the current page.
  ///
  /// Triggers a navigation event.
  void refresh() {
    // TODO: Implement reload logic
    // TODO: Notify listeners of navigation change
  }

  /// Loads a new URL, replacing the current page and clearing the forward history.
  ///
  /// Triggers a navigation event.
  void loadUrl(String url) {
    _navigationController.loadUrl(url);
    // TODO: Notify listeners of navigation change
  }

  /// Executes the given JavaScript code in the context of the current web page.
  ///
  /// Returns a unique ID that can be used to later identify and remove the injected script.
  ///
  /// Note: The actual implementation of JavaScript injection and ID generation will depend on the specific web rendering engine used.
  Future<String> executeJavaScript(String javaScriptCode) async {
    // TODO: Inject js code into the web page
    // TODO: Generate a unique ID for the injected script
    String jsID = ''; // Placeholder for the generated ID
    return jsID;
  }

  /// Removes a previously injected JavaScript script identified by its `javaScriptID`.
  ///
  /// Returns `true` if the script was successfully removed, `false` otherwise.
  ///
  /// Note: The actual implementation of script removal will depend on the specific web rendering engine used.
  Future<bool> removeJavaScript(String javaScriptID) async {
    // TODO: Locate the script in the web page using the `javaScriptID`
    // TODO: Remove the script from the web page
    return false; // Placeholder return value
  }

  /// Retrieves the title of the currently loaded web page.
  ///
  /// Returns an empty string if the title is not available yet.
  String getTitle() {
    // TODO: Fetch and return the title of the current web page
    return '';
  }

  /// Retrieves the complete URL of the currently loaded web page.
  ///
  /// Returns an empty string if the URL is not available yet.
  String getCompleteUrl() {
    // TODO: Fetch and return the complete URL of the current web page
    return '';
  }

  /// Checks if the web page is currently loading.
  ///
  /// Returns `true` if the page is still loading, `false` otherwise.
  bool isLoading() {
    // TODO: Return true if the web page is still loading, false otherwise
    return true;
  }

  /// Clears the browsing history based on the specified option.
  ///
  /// - `option`: Determines which part of the history to clear.
  ///   - `all`: Clears the entire history, excluding the current page.
  ///   - `before`: Clears all history entries before the current page.
  ///   - `after`: Clears all history entries after the current page.
  ///   - `current`: Clears only the current page and move to the previous page.
  ///
  /// If `option` is not provided or is invalid, the entire history is cleared by default, excluding the current page.
  void clearHistory({String option = 'all'}) => _navigationController.clearHistory(option);

  /// Adds the current web page to the user's favorites (bookmarks).
  void addToFavorites() {
    // TODO: Add the current page to favorites
  }

  /// Removes the current web page from the user's favorites (bookmarks).
  void removeFromFavorites() {
    // TODO: Remove the current page from favorites
  }

  double zoomLevel = 1.0;

  /// Sets the zoom level of the web page.
  ///
  /// The `zoomLevel` parameter represents a scaling factor (e.g., 1.0 for normal zoom, 1.5 for 150% zoom).
  void setZoomLevel({double zoomLevel = 1.0}) {
    // TODO: Set the zoom level of the web page
  }

  /// Finds text within the current web page.
  ///
  /// Returns a list of occurrences (e.g., line numbers or DOM element references).
  List<dynamic> findInPage(String searchText) {
    // TODO: Implement find-in-page functionality
    return [];
  }

  /// Checks if reader mode is currently enabled.
  bool get isReaderMode => _isReaderMode;
  bool _isReaderMode = false; // Flag to track reader mode

  /// Toggles reader mode on or off.
  void toggleReaderMode() {
    _isReaderMode = !_isReaderMode;
    // TODO: Update the web page rendering accordingly
  }

  /// Called when the browser starts loading a new page.
  ///
  /// This method is typically used to update the UI to indicate that a page is loading,
  /// such as showing a loading spinner or updating the address bar.
  ///
  /// The `url` parameter is the URL of the page being loaded.
  void onPageStarted(String url) {
    // TODO: Update UI to indicate page loading
    // You might want to display a loading indicator, update the address bar, etc.
  }

  /// Called when the browser finishes loading a new page.
  ///
  /// This method is typically used to update the UI to reflect the loaded page,
  /// such as hiding the loading spinner and updating the page title.
  ///
  /// The `url` parameter is the URL of the loaded page.
  void onPageFinished(String url) {
    // TODO: Update UI to reflect the loaded page
    // You might want to hide the loading indicator, update the page title, etc.
  }

  /// Called when the loading state of the web page changes.
  ///
  /// This method provides more granular information about the loading process compared to
  /// `onPageStarted` and `onPageFinished`. It can be used to track the progress of the loading,
  /// handle errors, and update the UI accordingly.
  ///
  /// The `isLoading` parameter indicates whether the page is currently loading.
  /// The `canGoBack` and `canGoForward` parameters indicate whether the browser can
  /// navigate backward or forward in the history.
  void onLoadingStateChange(bool isLoading, bool canGoBack, bool canGoForward) {
    // TODO: Handle loading state changes
    // You might want to update a progress bar, enable/disable navigation buttons, etc.
  }

  @override
  String toString() {
    return '''${_navigationController.toString()}
    Title: ${getTitle()},
    Reader mode: $isReaderMode
    ''';
  }
}
