/// Internal class for managing the navigation history of a web browser.
class BrowserNavigationController {
  /// Creates a `_BrowserNavigation` object with the specified `initialUrl`.
  BrowserNavigationController(String initialUrl) : _navigationList = [initialUrl];

  /// Stores the history of visited URLs.
  final List<String> _navigationList;

  /// The index of the currently displayed page in the history.
  int _currentIndex = 0;

  /// Gets the URL of the currently displayed page.
  String get currentURL => _navigationList[_currentIndex];

  /// Checks if the browser can navigate back to a previous page.
  bool get canGoBack => _currentIndex > 0;

  /// Checks if the browser can navigate forward to a next page.
  bool get canGoForward => _currentIndex < _navigationList.length - 1;

  /// Navigates to the previous page in the history.
  /// Returns true if the navigation was successful, false otherwise.
  bool goBack() {
    if (!canGoBack) return false;
    _currentIndex--;
    refresh();
    return true;
  }

  /// Navigates to the next page in the history.
  /// Returns true if the navigation was successful, false otherwise.
  bool goForward() {
    if (!canGoForward) return false;
    _currentIndex++;
    refresh();
    return true;
  }

  /// Reloads the current page.
  void refresh() {
    //TODO: Implement reload logic
  }

  /// Loads a new URL, replacing the current page and clearing the forward history if a new page is being loaded.
  ///
  /// If the new URL matches the next entry in forward history, navigates forward to avoid duplicate entries.
  /// Otherwise, clears forward history and updates the navigation list with the new URL.
  ///
  /// - `url`: The URL to load.
  void loadUrl(String url) {
    if (currentURL == url) return;

    if (canGoForward) {
      if (_navigationList[_currentIndex + 1] == url) {
        goForward();
        return;
      }
      // Remove forward history if navigating to a new page
      _navigationList.removeRange(_currentIndex + 1, _navigationList.length);
    }
    _navigationList.add(url);
    _currentIndex++;
    refresh();
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
  void clearHistory(ClearHistoryOption option) {
    final String currentPage = this.currentURL;
    switch (option) {
      case ClearHistoryOption.all:
        _navigationList.clear();
        _navigationList.add(currentPage); // Re-add the current page
        _currentIndex = 0; // Reset the current index
        break;
      case ClearHistoryOption.before:
        _navigationList.removeRange(0, _currentIndex);
        _currentIndex = 0; // Reset the current index
        break;
      case ClearHistoryOption.after:
        _navigationList.removeRange(_currentIndex + 1, _navigationList.length);
        break;
      case ClearHistoryOption.current:
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
    refresh();
  }

  @override
  String toString() {
    return '''Navigation:
    Current page: $currentURL;
    Can go back: $canGoBack;
    Can go forward: $canGoForward;
    Current history: $_navigationList ''';
  }
}

enum ClearHistoryOption {
  all,
  before,
  after,
  current,
}
