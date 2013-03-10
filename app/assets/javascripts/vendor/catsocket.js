function s4() {
  return Math.floor((1 + Math.random()) * 0x10000)
  .toString(16)
  .substring(1);
};

function guid() {
  return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
    s4() + '-' + s4() + s4() + s4();
}

var Catsocket = function(guid) {
  if (/localhost/.test(document.location.hostname) || /dev/.test(document)) {
    this._pollUrl = "http://catsocket_server.dev";
  } else {
    this._pollUrl = "http://catsocket.com:5100";
  }

  this._postUrl = this._pollUrl;

  this._observers = [];
  // We use this to filter requests when doing broadcast
  this._guid = guid;

  this._api_key = $("meta[name=catsocket-api-key]").attr("content");

  if (!this._api_key) {
    console.error("You need to provide an API key, check our documentation http://catsocket.com/tour");
  }

  this._polling = false;

  this._errback = function(response) {
    console.error("There was an error while connecting to the server");
  };
};

Catsocket.prototype.fetch = function(channel, callback) {
  var request = $.ajax({
    url: this._pollUrl,
    dataType: "json",
    data: {
      channel: channel,
      timestamp: this._timestamp
    },
    context: this,
    success: callback,
    // error: this._errback
  });

  return request;
};

Catsocket.prototype._fireObservers = function(body) {
  this._observers.forEach(function(observer) {
    if (body.messages.length > 0) {
      body.messages.forEach(function(message) {
        // guid 0 means the client wants to receive it's own broadcast
        if (message.guid === "0" || message.guid !== this._guid) {
          observer.call(this, JSON.parse(message.data));
        }
      }, this);
    }
  }, this);
};

Catsocket.prototype.poll = function(channel) {
  this._polling = true;

  this.fetch(channel, function(body, status, response) {
    var self = this;

    // Every response gives us either TS of the newest message,
    // or the TS we sent to the server
    this._timestamp = body.timestamp;

    this._fireObservers(body);

    if (this._polling) {
      setTimeout(function () { self.poll(channel) }, 100);
    }
  });
};

Catsocket.prototype.stop = function() {
  this._polling = false;
};

Catsocket.prototype.subscribe = function(channel, callback) {
  // We don't want messages from the past
  this._timestamp = new Date().getTime();

  this._observers.push(callback);

  if (!this._polling) {
    this.poll(channel);
  }
};

Catsocket.prototype.publish = function(channel, payload, includeSelf) {
  var guid = includeSelf ? 0 : this._guid;

  $.ajax({
    url: this._postUrl,
    context: this,
    method: "post",
    data: {
      channel: channel,
      data: payload,
      guid: guid
    }
  });
};

window.CS = new Catsocket(guid());
