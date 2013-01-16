#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require guiders
#= require_tree .

SITENAME = {
  common: {
    init: function() {
      // application-wide code
    }
  },

  home: {
    browse: function() {
      //guiders.createGuider({
      //  buttons: [{name: "Next"}],
      //  description: "Forking Recipes is a new kind of social recipe site, with some cool extra features.",
      //  id: "first",
      //  next: "second",
      //  overlay: true,
      //  title: "Welcome to Forking Recipes!"
      //}).show();

      // guiders.createGuider({
      //  attachTo: "#recent_recipes",
      //  buttons: [{name: "Next"}, {name: "Close"}],
      //  description: "Here you can see some of our newest recipes.",
      //  id: "second",
      //  next: "third",
      //  position: 3,
      //  title: "Welcome to Forking Recipes!"
      //});

      // guiders.createGuider({
      //  attachTo: "#recent_users",
      //  buttons: [{name: "Next"}, {name: "Close"}],
      //  description: "And over here some of our most popular users.",
      //  id: "third",
      //  next: "fourth",
      //  position: 9,
      //  title: "Welcome to Forking Recipes!"
      //});
    },
  }
};

UTIL = {
  exec: function( controller, action ) {
    var ns = SITENAME,
        action = ( action === undefined ) ? "init" : action;

    if ( controller !== "" && ns[controller] && typeof ns[controller][action] == "function" ) {
      ns[controller][action]();
    }
  },

  init: function() {
    var body = document.body,
        controller = body.getAttribute( "data-controller" ),
        action = body.getAttribute( "data-action" );

    UTIL.exec( "common" );
    UTIL.exec( controller );
    UTIL.exec( controller, action );
  }
};
$( document ).ready( UTIL.init );
