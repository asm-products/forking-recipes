#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require markdown.converter
#= require markdown.sanitizer
#= require markdown.editor
#= require_tree .

$(function(){
  var converter = Markdown.getSanitizingConverter();
  var editor = new Markdown.Editor(converter);

  editor.run();
})
