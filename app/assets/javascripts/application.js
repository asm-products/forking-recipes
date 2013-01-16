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
      guiders.createGuider({
        buttons: [{name: "Close"}],
        description: "Forking Recipes is a new kind of social recipe site, with some cool extra features.",
        id: "first",
        onHide:function() { window.location.href='/dpick#guider=user_first' },
        next: "user_second",
        overlay: true,
        title: "Welcome to Forking Recipes!"
      })
    }
  },

  users: {
    show: function() {
      guiders.createGuider({
        buttons: [{name: "Close"}],
        description: "This is a user page, here you can see all of their recipes. Let's take a look at one of them.",
        onHide: function() { window.location.href="/dpick/blackened-tilapia#guider=recipe_first" },
        id: "user_first",
        next: "recipe_first",
        title: "Welcome to Forking Recipes!"
      })
    }
  },

  recipes: {
    show: function() {
      guiders.createGuider({
        attachTo: "#revisions_button",
        buttons: [{name: "Close"}],
        description: "Here's a sample recipe. Unlike most recipe sites, we store every version of this recipe. Click on the revisions button to see how this recipe evolved.",
        id: "recipe_first",
        next: "recipe_second",
        position: 3,
        title: "Welcome to Forking Recipes!"
      })
    }
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
