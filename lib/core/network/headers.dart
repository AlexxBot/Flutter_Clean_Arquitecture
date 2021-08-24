class Headers {
  Map<String, String> _headers = {"content-type": 'application/json'};

  Map<String, String> get headers => this._headers;

  void addHeader(String key, String value) {
    if (!this._headers.containsKey(key)) {
      this._headers[key] = value;
    }
  }
}
