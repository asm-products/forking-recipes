#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require guiders
#= require jquery.masonry.min
#= require jquery.imagesloaded.min
#= require_tree .

SITENAME = {
  common: {
    init: function() {
      // application-wide code
    }
  },

  home: {
    browse: function() {
      var $container = $('#main-container');

      $container.imagesLoaded( function(){
        $container.masonry({
          itemSelector: '.item',
          //columnWidth: function(containerWidth) { return containerWidth / 4; },
        });
      });

      guiders.createGuider({
        buttons: [{name: "Close", onclick: guiders.hideAll}],
        description: '<h5>Forking Recipes is a new kind of social recipe site, with some cool extra features.</h5> <ul><li> Every change to a recipe is tracked so that users can see the evolution of recipes.</li><li>Recipes are formatted using a special syntax that allows them to look good but still remain portable.</li><li>Recipes can be "forked" from one user to another. This will take a recipe and copy it from one person&#39s profile to yours, so you can make your own changes to the recipe.</li><li>You can follow users and get a feed of what people are doing on the site.',
        id: "first",
        next: "user_second",
        overlay: true,
        title: "Welcome to Forking Recipes!"
      })
    }
  },

  users: {
    show: function() {
      guiders.createGuider({
        buttons: [{name: "Next", onclick: guiders.hideAll}],
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
        title: "Revisions"
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
