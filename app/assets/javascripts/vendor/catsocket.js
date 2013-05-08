(function() {
  function s4() {
    return Math.floor((1 + Math.random()) * 0x10000)
    .toString(16)
    .substring(1);
  };

  function guid() {
    return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
      s4() + '-' + s4() + s4() + s4();
  }

  var testing = function() {
    var local = /localhost/.test(document.location.hostname);
    var dev = /dev/.test(document.location.hostname);

    return !window.CATSOCKET_PRODUCTION && (local || dev);
  };

  var Catsocket = function(guid) {
    var self = this;

    if (testing()) {
      this._pollUrl = "http://localhost:5000";
    } else {
      this._pollUrl = "http://catsocket.com:5000";
    }

    this._postUrl = this._pollUrl;

    this._polling = [];
    this._observers = [];
    // We use this to filter requests when doing broadcast
    this._guid = guid;

    this._api_key = $("meta[name=catsocket-api-key]").attr("content");

    if (!this._api_key) {
      console.error("You need to provide an API key, check our documentation http://catsocket.com/tour");
    }

    var retryCount = 0, retryTimeout = 5000;

    this._errback = function(response) {
      if (retryCount > 2) {
        retryTimeout = 60000;
        console.error("There was an error while connecting to the server, retrying in 1 minute");
      } else {
        console.error("There was an error while connecting to the server, retrying in 5 seconds");
      }

      setTimeout(function() {
        self.fetch(self._last);
        retryCount++;
      }, retryTimeout);

    };
  };

  Catsocket.prototype.fetch = function(channel, callback) {
    var request = $.ajax({
      url: this._pollUrl,
      dataType: "json",
      data: {
        channel: channel,
        timestamp: this._timestamp,
        guid: this._guid,
        api_key: this._api_key
      },
      context: this,
      success: callback,
      error: this._errback
    });

    return request;
  };

  Catsocket.prototype._fireObservers = function(channel, body) {
    this._observers.forEach(function(observer) {
      if (body.data.length > 0 && observer.channel == channel) {
        body.data.forEach(function(message) {
          observer.callback.call(this, message);
        }, this);
      }
    }, this);
  };

  // Check if the client is polling a given channel
  Catsocket.prototype.isPolling = function(channel) {
    return this._polling.indexOf(channel) !== -1;
  };

  Catsocket.prototype.poll = function(channel) {
    this._last = channel;

    this.fetch(channel, function(body, status, response) {
      var self = this;

      // Every response gives us either TS of the newest message,
      // or the TS we sent to the server
      this._timestamp = body.timestamp;

      this._fireObservers(channel, body);

      if (this.isSubscribed(channel)) {
        setTimeout(function() { self.poll(channel) }, 1000);
      }
    });
  };

  // Make sure the client is polling the given channel
  Catsocket.prototype.ensurePoll = function(channel) {
    if (this._polling.indexOf(channel) === -1) {
      this.poll(channel);
    }
  };

  // Add a listener to a given channel
  Catsocket.prototype.addListener = function(channel, callback) {
    this._observers.push({ channel: channel, callback: callback });
    this.ensurePoll(channel);
  }

  // Check if the client is subscribed to a given channel
  Catsocket.prototype.isSubscribed = function(channel) {
    var result = false;
    this._observers.filter(function(item) {
      if (item.channel == channel) {
        result = true;
      }
    });

    return result;
  };

  Catsocket.prototype.subscribe = function(channel, callback) {
    console.log("subscribed to channel", channel);
    // We don't want messages from the past
    this._timestamp = new Date().getTime();

    if (!this.isSubscribed(channel)) {
      this.addListener(channel, callback);
    }
  };

  Catsocket.prototype.unsubscribe = function(channel) {
    if (this.isSubscribed(channel)) {
      var result = null;

      this._observers.filter(function(observer) {
        if (observer.channel === channel) {
          restult = observer;
        }
      });

      this._observers.splice(this._observers.indexOf(result), 1);
    }
  };

  // Stop polling and unsubscribe from all channels
  Catsocket.prototype.stop = function() {
    this._observers.splice(0, this._observers.length);
  };

  Catsocket.prototype.publish = function(channel, payload, includeSelf) {
    console.log("publish to channel", channel);
    var guid = includeSelf ? 0 : this._guid;

    $.ajax({
      url: this._postUrl,
      context: this,
      method: "post",
      data: {
        channel: channel,
        data: payload,
        guid: guid,
        api_key: this._api_key
      }
    });
  };

  window.CS = new Catsocket(guid());
})();

