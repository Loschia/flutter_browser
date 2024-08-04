/// Internal class for managing the navigation history of a web browser.
class BrowserNavigationController {
  /// Creates a `_BrowserNavigation` object with the specified `initialUrl`.
  BrowserNavigationController(String initialUrl) : _navigationList = [initialUrl];

  final List<String> _navigationList;

  /// Stores the history of visited URLs.
  int _currentIndex = 0;

  /// The index of the currently displayed page in the history.

  /// Gets the URL of the currently displayed page.
  String get currentPage => _navigationList[_currentIndex];

  /// Checks if the browser can navigate back to a previous page.
  bool get canGoBack => _currentIndex > 0;

  /// Checks if the browser can navigate forward to a next page.
  bool get canGoForward => _currentIndex < _navigationList.length - 1;

  /// Navigates to the previous page in the history.
  /// Returns true if the navigation was successful, false otherwise.
  bool goBack() {
    if (!canGoBack) return false;
    _currentIndex--;
    return true;
  }

  /// Navigates to the next page in the history.
  /// Returns true if the navigation was successful, false otherwise.
  bool goForward() {
    if (!canGoForward) return false;
    _currentIndex++;
    return true;
  }

  /// Reloads the current page.
  void refresh() {
    // TODO: Implement reload logic
  }

  /// Loads a new URL, replacing the current page and clearing the forward history.
  void loadUrl(String url) {
    if (canGoForward) {
      // Remove forward history if we're navigating to a new page
      _navigationList.removeRange(_currentIndex + 1, _navigationList.length);
    }
    _navigationList.add(url);
    _currentIndex++;
  }

  /// Clears the browsing history based on the specified option.
  ///
  /// - `option`: Determines which part of the history to clear.
  ///   - `all`: Clears the entire history, excluding the current page.
  ///   - `before`: Clears all history entries before the current page.
  ///   - `after`: Clears all history entries after the current page.
  ///   - `current`: Clears only the current page and move to the previous page.
  ///
  /// If `option` is not provided or is invalid, the entire history is cleared by default.
  void clearHistory(String option) {
    final currentPage = this.currentPage;
    switch (option) {
      case 'all':
        _navigationList.clear();
        _navigationList.add(currentPage); // Re-add the current page
        _currentIndex = 0; // Reset the current index
        break;
      case 'before':
        _navigationList.removeRange(0, _currentIndex);
        _currentIndex = 0; // Reset the current index
        break;
      case 'after':
        _navigationList.removeRange(_currentIndex + 1, _navigationList.length);
        break;
      case 'current':
        _navigationList.removeAt(_currentIndex);
        if (_currentIndex > 0) {
          _currentIndex--; // Move to the previous page
        }
        break;
      default:
        _navigationList.clear();
        _navigationList.add(currentPage); // Re-add the current page
        _currentIndex = 0; // Reset the current index
        break;
    }
    // TODO: Notify listeners of navigation change
  }

  @override
  String toString() {
    return '''Navigation:
    Current page: $currentPage;
    Can go back: $canGoBack;
    Can go forward: $canGoForward;
    Current history: $_navigationList ''';
  }
}
