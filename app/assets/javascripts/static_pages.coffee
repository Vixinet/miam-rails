# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# $ ->
$(document).on "turbolinks:load", ->
  $(".typed").typed
    strings: [
      "chinois",
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
  
  $('.list-group.cities').addClass("animate-hidden").viewportChecker
    classToAdd: 'animate-visible animated fadeInLeft'

  $('.cities-add').addClass("animate-hidden").viewportChecker
    classToAdd: 'animate-visible animated slideInUp'

  $('.optins form').addClass("animate-hidden").viewportChecker
    classToAdd: 'animate-visible animated bounceIn'

  $('.optins .titles').addClass("animate-hidden").viewportChecker
    classToAdd: 'animate-visible animated fadeInUp'

  $("#new_opt_in").on "ajax:success", ->
    $("#new_opt_in").html "<p class=\"lead\">Inscription prise en compte. &#128077;</p>"
    # fbq('track', 'Lead')
  
  $("#new_opt_in").on "ajax:error", ->
    toastr.error("&#128557; Une erreur est survenue. Êtes-vous certain d'avoir remplis le bon email?", {timeOut: 10000})

  $("#new_city").on "ajax:success", ->
    $("#new_city").html "<p class=\"text-center\">Ville enregistrée. Notre équipe dois la validée avant l'affichage sur le site. &#128077;</p>"
    fbq('track', 'Lead')
  
  $("#new_city").on "ajax:error", ->
    toastr.error("Avez-vous ajouté votre nom de ville dans le champs texte?", {timeOut: 10000})

  $(".list-group-item").on "ajax:success", ->
    $('.badge.vote').remove();
    toastr.info("Vote pris en compte! &#128077;", {timeOut: 10000})

