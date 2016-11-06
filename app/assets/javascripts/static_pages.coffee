# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $ ->
$(document).on "turbolinks:load", ->
  $(".typed").typed
    strings: [
      # "chinois",
      # "sushis",
      # "japonais",
      # "crêpes",

      "africain", 
      "burger", 
      "thaï", 
      "pasta", 
      "pizza", 
      "lasagne", 
      "panini", 
      "kebab", 
      "falafel", 
      "sandwich", 
      "salade", 
      "tartare", 
      "brésilien"
    ]
    shuffle: true
    loop: true
    typeSpeed: 50,
    backSpeed: 30,
    backDelay: 700
