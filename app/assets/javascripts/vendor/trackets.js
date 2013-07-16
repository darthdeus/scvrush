(function(window, document, $) {

  function assert(condition, message) {
    if (!condition) {
      throw new Error("Assertion Error: " + message);
    }
  };

  window.Trackets = {

    init: function(options) {
      assert(options, "api_key is required.");
      options = options || {};

      this.api_base_url = options.api_base_url || "http://trackets.dev";
      this.api_key = options.api_key;
      this.callback = options.callback;

      console.log("initialized with api_key", options.api_key);

      window.onerror = this.exceptionHandler.bind(this);
    },

    /**
      Serialize all browser data about the client session
      into a single data object.
     */
    serialize: function(message, fileName, lineNumber) {
      var data = {
        api_key: this.api_key,
        error: {
          message: message,
          file_name: fileName,
          line_number: lineNumber,
          url: document.location.href,
          browser: navigator.userAgent,
          stacktrace: getStackTrace()
        }
      };

      return data;
    },

    exceptionHandler: function(message, filename, lineNumber) {
      this.notify(message, filename, lineNumber);
    },

    notify: function(message, filename, lineNumber) {
      assert(this.api_key, "api_key is required");

      $.ajax({
        url: this.api_base_url + "/reports",
        method: "POST",
        context: this,
        global: false, // TODO - look into this
        data: this.serialize(message, filename, lineNumber),
      }).then(this.ajaxSuccessHandler, this.ajaxErrorHandler);
    },

    ajaxSuccessHandler: function() {
      if (this.callback) {
        try {
          this.callback();
        } catch (e) {
          console.error(e);
        }
      }
    },

    ajaxErrorHandler: function(xhr, status, message) {
      console.log(message);
      this.lastError = message;
    },

    test: function() {
      throw new Error("Trackets: Test Error.");
    }
  };

})(window, document, jQuery);
