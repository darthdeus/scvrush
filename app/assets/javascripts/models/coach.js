// Scvrush.Coach = DS.Model.extend({
//   title:   DS.attr("string"),
//   order:   DS.attr("number"),
//   post_id: DS.attr("number")
// });

// Scvrush.Coach = Ember.Object.extend();
// Scvrush.Coach.reopenClass({
//   _listOfShoes:  Em.A(),
//   _stubDataSource:  [
//           { id: 'rainbow',   name: "Rainbow Sandals",
//               price: '$60.00', description: 'San Clemente style' },
//           { id: 'strappy',   name: "Strappy shoes",
//               price: '$300.00', description: 'I heard Pénèlope Cruz say this word once.' },
//           { id: 'bluesuede', name: "Blue Suede",
//               price: '$125.00', description: 'The King would never lie:  TKOB⚡!' }
//         ],
//   all:  function(){
//     var allShoes = this._listOfShoes;
//     // Stub an ajax call; like a jQuery.ajax might have done...
//     setTimeout( function(){
//       allShoes.clear();
//       allShoes.pushObjects(this._stubDataSource);
//     }, 2000);
//     return this._stubDataSource;
//   },
//   find:  function(id){
//     return this._stubDataSource.findProperty('id', id);
//   }
// });
