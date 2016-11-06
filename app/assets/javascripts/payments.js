$(document).on("turbolinks:load", function() {
  var cc_number = $('#payment_cc_number');
  var cc_exp = $('#payment_cc_exp');
  var cc_cvc = $('#payment_cc_cvc');

  cc_number.payment('formatCardNumber');
  cc_exp.payment('formatCardExpiry');
  cc_cvc.payment('formatCardCVC');

  $(document).on('submit.rails', '.payments_new', function(event) {
    var err = false;

    if( !$.payment.validateCardNumber(cc_number.val()) ) {
      toastr.error('Numéro de carte de crédit invalide');
      cc_number.closest('div').addClass('field_with_errors');
      err = true;
    } else {
      cc_number.closest('div').removeClass('field_with_errors');
    }

    if( !$.payment.validateCardExpiry(cc_exp.payment('cardExpiryVal').month, cc_exp.payment('cardExpiryVal').year) ) {
      toastr.error('Date d\'expiration invalide');
      cc_exp.closest('div').addClass('field_with_errors');
      err = true;
    } else {
      cc_exp.closest('div').removeClass('field_with_errors');
    }
    
    if( !$.payment.validateCardCVC(cc_cvc.val()) ) {
      toastr.error('Code de sécurité invalide');
      cc_cvc.closest('div').addClass('field_with_errors');
      err = true;
    } else {
      cc_cvc.closest('div').removeClass('field_with_errors');
    }
    
    if( err ) {
      event.preventDefault();
      event.stopPropagation();
      var form = $(this);
      setTimeout(function(){  
      	$.rails.enableFormElements(form) 
      }, 100);
    }
  })
});