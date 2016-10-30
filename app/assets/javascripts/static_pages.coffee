# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $ ->
$(document).on "turbolinks:load", ->
  $(".typed").typed
    strings: [
      "chinois",
      "pizza",
      "pasta"
      "sushis"
      "japonais"
      "crêpes"
      "kebab"
      "burger"
      "salade"
      "thai"
    ]
    shuffle: true
    loop: true
    typeSpeed: 50,
    backSpeed: 30,
    backDelay: 700
  
  $("#new_opt_in").on "ajax:success", ->
    $("#new_opt_in").html "<p class=\"lead\">Inscription prise en compte. &#128077;</p>"
    fbq('track', 'Lead')
  
  $("#new_opt_in").on "ajax:error", ->
    toastr.error("&#128557; Une erreur est survenue. Êtes-vous certain d'avoir remplis le bon email?", {timeOut: 10000})

