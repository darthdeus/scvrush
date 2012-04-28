window.App = window.App || {}
var App = window.App;

// Login form abstraction, simply pass in a form template
// and call the `show()` method to display the form.
App.LoginForm = function(template) {
  var self = this;

  // login form submission callback
  this.send = function(content) {
    var payload = {
      username: self.content.find('input[name=username]').val(),
      password: self.content.find('input[name=password]').val()
    };

    $.ajax({
      method: 'POST',
      url: '/api/login',
      data: payload,
      success: self.successCallback,
      error: self.errorCallback
    });
  }

  // callback for successful login
  this.successCallback = function(data) { document.location.reload(true); },

  // callback for error form submission
  this.errorCallback = function(data) {
    self.content.find('.control-group').addClass('error');
    self.content.find('legend').fadeOut(function() {
      $(this).text('Invalid login').css('color', '#B94A48').fadeIn();
    });
  };

  this.show = function() {
    // show the fancybox with a given login form
    $.fancybox({
      // just in case raw HTML gets passed, we need to keep the events hooked,
      // without the $() wrap, the events bound in `onComplete` won't work
      content: $(template),
      onComplete: self.fancyboxLoaded
    });
  };

  // fancybox onComplete callback
  this.fancyboxLoaded = function() {
    var submit = this.content.find('button[type=submit]');

    // the fancybox itself is the context here,
    // we need to assign the content for AJAX callbacks
    self.content = this.content;

    // submit the form via AJAX
    submit.click(function(e) {
      e.preventDefault();
      self.send(self.content);
    });

    // focus the first element to be less annoying
    this.content.find('input:first').focus();
  };

};

$(function() {

  window.loginForm = new App.LoginForm($('#login_form').html());

  $('.js-login-link').click(function(e) {
    e.preventDefault();
    window.loginForm.show();
  });

});
