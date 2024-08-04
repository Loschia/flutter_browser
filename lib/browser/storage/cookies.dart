/// Represents an HTTP cookie.
class Cookie {
  /// Creates a `Cookie` object with the specified attributes.
  ///
  /// - `name`: The name of the cookie (required).
  /// - `value`: The value of the cookie (required).
  /// - `domain`: The domain for which the cookie is valid (optional).
  /// - `path`: The path on the server to which the cookie applies (optional).
  /// - `expires`: The expiration date and time of the cookie (optional).
  /// - `httpOnly`: Whether the cookie should be accessible only through HTTP (optional).
  /// - `secure`: Whether the cookie should be sent only over HTTPS (optional).
  /// - `sameSite`: The SameSite attribute of the cookie (optional).
  Cookie({
    required this.name,
    required this.value,
    this.domain,
    this.path,
    this.expires,
    this.httpOnly,
    this.secure,
    this.sameSite,
  });

  /// The name of the cookie.
  final String name;

  /// The value of the cookie.
  String value;

  /// The domain for which the cookie is valid.
  final String? domain;

  /// The path on the server to which the cookie applies.
  final String? path;

  /// The expiration date and time of the cookie.
  DateTime? expires;

  /// Whether the cookie should be accessible only through HTTP.
  bool? httpOnly;

  /// Whether the cookie should be sent only over HTTPS.
  bool? secure;

  /// The SameSite attribute of the cookie.
  String? sameSite;

  /// Creates a `Cookie` object from a JSON-serializable map.
  factory Cookie.fromJson(Map<String, dynamic> json) => Cookie(
        name: json['name'] as String? ?? '',
        value: json['value'] as String? ?? '',
        domain: json['domain'] as String?,
        path: json['path'] as String?,
        expires: json['expires'] != null ? DateTime.parse(json['expires']) : null,
        httpOnly: json['httpOnly'] as bool?,
        secure: json['secure'] as bool?,
        sameSite: json['sameSite'] as String?,
      );

  /// Converts the `Cookie` object to a JSON-serializable map.
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'value': value,
        'domain': domain,
        'path': path,
        'expires': expires?.toIso8601String(),
        'httpOnly': httpOnly,
        'secure': secure,
        'sameSite': sameSite,
      };

  /// Checks if the cookie has expired.
  bool get isExpired => expires != null && DateTime.now().isAfter(expires!);

  /// Checks if the cookie has an empty value
  bool get isEmptyValue => value.isEmpty;

  /// Creates a copy of the `Cookie` object.
  Cookie copy() => Cookie(
        name: name,
        value: value,
        domain: domain,
        path: path,
        expires: expires,
        httpOnly: httpOnly,
        secure: secure,
        sameSite: sameSite,
      );

  @override
  String toString() {
    return toJson().toString();
  }
}
