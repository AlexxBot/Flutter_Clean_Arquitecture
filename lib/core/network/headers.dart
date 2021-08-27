class Headers {
  Map<String, String> _headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8'
    /* "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "DELETE, POST, GET",
    "Access-Control-Allow-Headers":
        "Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With" */
    //"Access-Control-Allow-Headers":
    //"Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With"
  };

  Map<String, String> get headers => this._headers;

  void addHeader(String key, String value) {
    if (!this._headers.containsKey(key)) {
      this._headers[key] = value;
    }
  }
}
