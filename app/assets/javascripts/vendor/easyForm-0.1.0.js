// Last commit: c5a8536 (2013-02-21 11:28:28 -0500)


(function() {
Ember.EasyForm = Ember.Namespace.create({
  VERSION: '0.0.1'
});

})();



(function() {
Ember.Handlebars.registerHelper('error', function(property, options) {
  if (this.errors) {
    options.hash.context = this;
    options.hash.property = property;
    return Ember.Handlebars.helpers.view.call(this, Ember.EasyForm.Error, options);
  }
});

})();



(function() {
Ember.Handlebars.registerBoundHelper('formFor', function(object, options) {
  options.hash.context = object;
  return Ember.Handlebars.helpers.view.call(object, Ember.EasyForm.Form, options);
});

})();



(function() {
Ember.Handlebars.registerHelper('input', function(property, options) {
  options.hash.inputOptions = Ember.copy(options.hash);
  options.hash.context = this;
  options.hash.property = property;
  return Ember.Handlebars.helpers.view.call(this, Ember.EasyForm.Input, options);
});

})();



(function() {
Ember.Handlebars.registerHelper('submit', function(value, options) {
  if (typeof(value) === 'object') {
    options = value;
    value = undefined;
  }
  options.hash.context = this;
  options.hash.value = value || 'Submit';
  return Ember.Handlebars.helpers.view.call(this, Ember.EasyForm.Submit, options);
});

})();



(function() {
Ember.Handlebars.registerHelper('textArea', function(property, options) {
  options.hash.valueBinding = property;
  return Ember.Handlebars.helpers.view.call(this, Ember.TextArea, options);
});

})();



(function() {
Ember.Handlebars.registerHelper('textField', function(property, options) {
  options.hash.valueBinding = property;
  return Ember.Handlebars.helpers.view.call(this, Ember.TextField, options);
});

})();



(function() {

})();



(function() {
Ember.EasyForm.Error = Ember.View.extend({
  tagName: 'span',
  classNames: ['error'],
  init: function() {
    this._super();
    this.set('template', Ember.Handlebars.compile('{{errors.'+this.property+'}}'));
  }
});

})();



(function() {
Ember.EasyForm.Form = Ember.View.extend({
  tagName: 'form',
  attributeBindings: ['novalidate'],
  novalidate: 'novalidate',
  submit: function(event) {
    if (this.get('context').validate === undefined || this.get('context').validate()) {
      this.get('controller').send('submit');
    }
    if (event) {
      event.preventDefault();
    }
  }
});

})();



(function() {
Ember.EasyForm.Input = Ember.View.extend({
  tagName: 'div',
  classNames: ['input', 'string'],
  classNameBindings: ['error:field_with_errors'],
  init: function() {
    this._super();
    this.set('model', this._context);
    this.set('template', Ember.Handlebars.compile('<label for="'+this.labelFor()+'"}}>'+this.labelText()+'</label>\n{{'+this.inputHelper()+' '+this.property+this.printInputOptions()+'}}{{error '+this.property+'}}'));
    if(this.model.errors) {
      this.reopen({
        error: function() {
          return this.model.errors.get(this.property) !== undefined;
        }.property('model.errors.'+this.property)
      });
    }
  },
  labelFor: function() {
    return Ember.guidFor(this.model);
  },
  labelText: function() {
    return this.label || this.property.underscore().split('_').join(' ').capitalize();
  },
  inputHelper: function() {
    if(this.as === 'text') {
      return 'textArea';
    } else {
      return 'textField';
    }
  },
  printInputOptions: function() {
    var string = '', key, inputOptions;
    inputOptions = this.prepareInputOptions(this.inputOptions);
    if (inputOptions) {
      for (key in inputOptions) {
        string = string.concat('' + key + '="' + this.inputOptions[key] + '"');
      }
      string.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
      return ' ' + string;
    }
  },
  prepareInputOptions: function(options) {
    var context;
    if (!options.type) {
      if (this.property.match(/password/)) {
        options.type = 'password';
      } else if (this.property.match(/email/)) {
        options.type = 'email';
      } else {
        // controller
        if (this._context.content) {
          context = this._context.content;
        } else {
          context = this._context;
        }
        if ((typeof(context.constructor.metaForProperty) === 'function' && context.constructor.metaForProperty(this.property).type === 'number') || typeof(context[this.property]) === 'number') {
          options.type = 'number';
        } else if ((typeof(context.constructor.metaForProperty) === 'function' && context.constructor.metaForProperty(this.property).type === 'date') || (context[this.property] !== undefined && context[this.property].constructor === Date)) {
          options.type = 'date';
        }
      }
    }
    return options;
  },
  focusOut: function() {
    if (this.model.validate) {
      this.model.validate(this.property);
    }
  }
});

})();



(function() {
Ember.EasyForm.Submit = Ember.View.extend({
  tagName: 'input',
  attributeBindings: ['type', 'value'],
  type: 'submit',
  init: function() {
    this.set('value', this.value);
  },
  onClick: function() {
    if (this.get('context').validate()) {
      this.get('controller').send('submit');
    }
  }
});

})();



(function() {

})();



(function() {
Ember.TEMPLATES['easyForm/input'] = Ember.Handlebars.compile('<label {{bindAttr for="labelFor"}}>{{labelText}}</label>');

})();



(function() {

})();



(function() {
Ember.EasyForm.objectNameFor = function(object) {
  var constructorArray = object.constructor.toString().split('.');
  return constructorArray[constructorArray.length - 1].underscore();
};

})();



(function() {

})();

