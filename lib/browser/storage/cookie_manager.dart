import 'cookies.dart';

/// Manages a collection of HTTP cookies
class CookieManager {
  /// Creates an empty `CookieManager`.
  CookieManager({Set<Cookie>? cookies}) : _cookies = cookies ?? {};

  Set<Cookie> _cookies; // Set to store cookies

  /// Creates a `Cookie` object from a JSON-serializable map.
  factory CookieManager.fromJson(Set<Map<String, dynamic>> json) {
    Set<Cookie> cookies = {};
    for (Map<String, dynamic> map in json) {
      cookies.add(Cookie.fromJson(map));
    }
    return CookieManager(cookies: cookies)..cleanUpCookies();
  }

  /// Converts the `Cookie` object to a JSON-serializable map.
  Set<Map<String, dynamic>> toJson() {
    Set<Map<String, dynamic>> json = {};
    for (var cookie in _cookies) {
      json.add(cookie.toJson());
    }

    return json;
  }

  /// Adds a `cookie` to the manager, replacing any existing cookie with the same name, domain, and path
  void addCookie(Cookie cookie) {
    _cookies.removeWhere((c) => (c.name == cookie.name) && (c.domain == cookie.domain) && (c.path == cookie.path));
    _cookies.add(cookie);
    _notifyBrowser();
  }

  /// Adds a list of `cookie` to the manager, replacing any existing cookie with the same name, domain, and path
  void addCookies(List<Cookie> cookies) {
    for (int i = 0; i < cookies.length; i++) {
      _cookies.removeWhere((c) => (c.name == cookies[i].name) && (c.domain == cookies[i].domain) && (c.path == cookies[i].path));
    }

    _cookies.addAll(cookies);
    _notifyBrowser();
  }

  /// Retrieves a `cookie` by its `name`, `domain`, and `path`.
  /// Returns null if no matching cookie is found
  Cookie? getCookie(String name, String? domain, String? path) {
    try {
      return _cookies.firstWhere((cookie) => (cookie.name == name) && (cookie.domain == domain) && (cookie.path == path));
    } catch (e) {
      return null;
    }
  }

  /// Updates an existing `cookie`'s attributes.
  /// If the `cookie` doesn't exist, no action is taken
  void updateCookie({
    required String name,
    required String? domain,
    required String? path,
    String? value,
    DateTime? expires,
    bool? httpOnly,
    bool? secure,
    String? sameSite,
  }) {
    Cookie? cookie = getCookie(name, domain, path);
    if (cookie == null) return;

    cookie.value = value ?? cookie.value;
    cookie.expires = expires ?? cookie.expires;
    cookie.httpOnly = httpOnly ?? cookie.httpOnly;
    cookie.secure = secure ?? cookie.secure;
    cookie.sameSite = sameSite ?? cookie.sameSite;
    _notifyBrowser();
  }

  /// Deletes a `cookie` by its `name`, `domain`, and `path`
  void deleteCookie(String name, String? domain, String? path) {
    _cookies.removeWhere((cookie) => (cookie.name == name) && (cookie.domain == domain) && (cookie.path == path));
    _notifyBrowser();
  }

  /// Periodically checks for and removes expired or empty-valued `cookie`s.
  void cleanUpCookies() {
    _cookies.removeWhere((cookie) => cookie.isExpired || cookie.isEmptyValue);
    _notifyBrowser(); // TODO: Notify the browser of the changes
  }

  /// Gets all cookies stored in the manager
  Set<Cookie> get getAllBrowserCookies => _cookies;

  /// Gets all cookies matching the given `domain` and `path`
  Set<Cookie> getAllCookies(String? domain, String? path) =>
      _cookies.where((cookie) => (cookie.domain == domain) && (cookie.path == path)).toSet();

  void _notifyBrowser() {
    //TODO: notify browser
  }

  @override
  String toString() {
    return _cookies.toString();
  }
}
