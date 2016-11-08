$(document).on("turbolinks:load", function() {

  // helpers

  var _get = function(_this, _class) {
    return $(_this).hasClass(_class) ? $(_this) : $(_this).closest('.' + _class);
  }

  var _get_product = function(_this) {
    return _get(_this, 'product')
  }

  var _get_variation = function(_this) {
    return _get(_this, 'product_variation')
  }

  var _get_option = function(_this) {
    return _get(_this, 'variation_option')
  }

  var _id = function(elem) {
    return elem.attr('data-id')
  };

  var _label = function(elem) {
    return elem.attr('data-label');
  };

  var _allow_multi = function(elem) {
    return elem.attr('data-allow-multi-choice') == "true"
  };

  var _multi_limit = function(elem) {
    return parseInt(elem.attr('data-multi-choice-limit'))
  };

  var _quantity = function(elem) {
    return parseInt(elem.attr('data-quantity'))
  };

  var _has_default = function(elem) {
    return elem.attr('data-has-default') == "true"
  };

  var _is_default = function(elem) {
    return elem.attr('data-is-default') == "true"
  };

  var _base_price = function(product) {
    return parseFloat(product.attr('data-base-price'));
  };

  var _variation_price = function(option) {
    return parseFloat(option.attr('data-variation-price'));
  };

  var _count_selected_options = function(variation) {
    return variation.find('.variation_option').length - variation.find('.variation_option[data-quantity="0"]').length
  };

  var _is_active = function(elem) {
    return elem.hasClass('active');
  };

  var _get_options_and_total = function(parent) {

    var total = 0, _options = [];
  
    parent.find('.variation_option[data-quantity!="0"]').each(function(index, option) {
      option = $(option);
      _options.push({
        id: _id(option),
        label: _label(option),
        quantity: _quantity(option),
        variation_price: _variation_price(option),
      });
      total += _quantity(option) * _variation_price(option);
    });

    return { 
      options: _options,
      total: total
    };
  };

  // Methods

  var make_inactive = function(elem) {
    elem.removeClass('active')
  };

  var make_product_active = function(product) {
    make_inactive($('.product.active'));
    product.addClass('active');
  };

  var toggle_product = function(product) {
    if(_is_active(product)) {
      make_inactive(product);
    } else {
      make_product_active(product);
    }
  };

  var toggle_variation = function(variation) {
    if(_is_active(variation)) {
      make_inactive(variation);
      handle_variation_label(variation);
    } else {
      var old = $('.product_variation.active');
      if( old.length > 0 ) {
        make_inactive(old);
        handle_variation_label(old);
      }
      variation.addClass('active');
      handle_variation_label(variation);
    }
  };

  var handle_variation_label = function(variation) {
    var label = variation.find('.info');
    if( _is_active(variation) ) {
      if( _allow_multi(variation) ) {
        if( _multi_limit(variation) == 0 ) {
          var text = 'choisissez';
        } else {
          var text = 'max ' + _multi_limit(variation) + ' choix';
        }
      } else {
        var text = 'choisissez en 1';
      }
    } else {
      var data = _get_options_and_total(variation).options;
      var text = '';
      for(var i = 0; i < data.length; i++) {
        text +=  (i>0?', ':'') + data[i].label + (data[i].quantity > 1 ? '×' + data[i].quantity : '');
      }
    }
    label.text(text);
  };

  var toggle_option = function(option) {
    var variation = _get_variation(option);
    if( _quantity(option) > 0 ) {
      if( _allow_multi(option) ) {
        if( _multi_limit(option) == 0 || _multi_limit(option) > _quantity(option) ) {
          change_option_quantity(option, null, 1);
        } else {
          if( !_has_default(variation) || _count_selected_options(variation) > 1) {
            change_option_quantity(option, 0);
          } else {
            change_option_quantity(option, 1);
          }
        }
      } else {
        if( !_has_default(variation) || _count_selected_options(variation) > 1) {
          change_option_quantity(option, 0);
        }
      }
    } else {
      if( _allow_multi(variation) ) {
        if( _multi_limit(variation) == 0 || _multi_limit(variation) > _count_selected_options(variation) )  {
          change_option_quantity(option, 1);
        } else {
          // rien faire
        }
      } else {
        variation.find('.variation_option').each(function(index, _option) {
          var _option = $(_option);
          if( _id(_option) != _id(option) ) {
            change_option_quantity(_option, 0);    
          }
        })
        change_option_quantity(option, 1);
      }
    }
  };

  var change_option_quantity = function(option, quantity, delta) {
    if( typeof delta === typeof undefined ) {
      var new_quantity = quantity;
    } else {
      var new_quantity = _quantity(option) + delta;
    }
    
    option.attr('data-quantity', new_quantity);

    if( new_quantity > 0 && _quantity(_get_product(option)) == 0 ) {
      change_product_quantity(_get_product(option), 1);
    } else if( _variation_price(option) > 0 ) {
      refresh_ui(_get_product(option))
    } else {
      refresh_option_ui(option);
    }
  };

  var duplicate_product = function(_this) {
    var base_product = _get_product(_this);
    var new_product = base_product.clone();
    new_product.insertAfter(base_product);
    make_product_active(new_product);
  };

  var check_product_check_box = function(_this) {
    if(_is_active($(_this))) {
      change_product_quantity(_get_product(_this), 0);
    } else {
      change_product_quantity(_get_product(_this), 1);
    }
  };

  var change_product_quantity = function(product, quantity, delta) {
    if(typeof delta === typeof undefined) {
      var new_quantity = quantity;
    } else {
      var base_quantity = parseInt(product.attr('data-quantity'));
      var new_quantity = base_quantity + delta;
    }
    
    product.attr('data-quantity', Math.max(0, new_quantity));

    if(new_quantity == 0) {
      make_inactive(product);
    }

    refresh_ui(product);
  };

  // UI

  var refresh_ui = function(product) {
    var quantity = _quantity(product);
    var base_price = _base_price(product) + _get_options_and_total(product).total;
    var total_price = base_price * quantity;

    product.find('.display_quantity').text(quantity);
    product.find('.display_price').text(_convertTwoDecimals(Math.max(total_price, base_price)));
    product.find('.flagged_quantity').text(quantity > 1 ? '×'+quantity : ' ');

    if( quantity > 0) {
      product.find('.check_box').addClass('active');
    } else {
      product.find('.check_box').removeClass('active');
    }

    product.find('.product_variation').each(function(index, variation) {
      
      var variation = $(variation);

      handle_variation_label(variation);

      variation.find('.variation_option').each(function(index, option) {
        refresh_option_ui($(option))
      });
    });
  };

  var refresh_option_ui = function(option) {
    option.find('.variation_toggle_price').text(_convertTwoDecimals(_variation_price(option)));

    if( _quantity(option) > 0 ) {
      option.find('.variation_toggle_check_box').addClass('active');
    } else {
      option.find('.variation_toggle_check_box').removeClass('active');
    }
    
    if( _allow_multi(option) ) {
      option.find('.variation_toggle_check_box').text( _quantity(option) < 2 ? '' : _quantity(option) );
    }
  }

  // Events

  $('.products')

  .on('click', '[data-action="_product_toggle"]', function(event) {
    event.preventDefault()
    toggle_product(_get_product(this));
  })

  .on('click', '[data-action="_count_plus"]', function(event) {
    event.preventDefault()
    change_product_quantity(_get_product(this), null, +1);
  })

  .on('click', '[data-action="_count_minus"]', function(event) {
    event.preventDefault()
    change_product_quantity(_get_product(this), null, -1);
  })

  .on('click', '[data-action="_check_box"]', function(event) {
    event.preventDefault();
    event.stopPropagation();
    check_product_check_box(this);
  })

  .on('click', '[data-action="_duplicate"]', function(event) {
    event.preventDefault()
    duplicate_product(this);
  })

  .on('click', '[data-action="_product_variation_toggle"]', function(event) {
    event.preventDefault()
    toggle_variation(_get_variation(this));
  })

  .on('click', '[data-action="_variation_option_toggle"]', function(event) {
    event.preventDefault();
    toggle_option(_get_option(this));
  })

  $(document)

  .on('submit.rails', '.new_order', function(event) {
    var products = [];

    $('.product[data-quantity != "0"]').each(function(index, product) {
      var $product = $(product);

      var variations = [];

      $product.find('.product_variation').each(function(index, variation) {
        $variation = $(variation);

        $options = $variation.find('.variation_option[data-quantity != "0"]');

        if( $options.length == 0)
          return;

        var options = [];

        $options.each(function(index, option) {
          $option = $(option);
          options.push({
            id: $option.data('id'),
            quantity: $option.data('quantity')
          })
        });

        variations.push({
          id: $variation.data('id'),
          options: options
        });
      });

      console.log($product);

      products.push({
        id: $product.data('id'),
        quantity: $product.data('quantity'),
        variations: variations
      });

    });

    if( products.length == 0 ) {
      event.preventDefault();
      toastr.error("Vous n'avez pas selectioné de produits.")
      var form = $(this);
      setTimeout(function(){  
        $.rails.enableFormElements(form) 
      }, 100);
      return false;
    }

    $('#order_products').val(JSON.stringify(products)).appendTo(this);
    
  });

  // Init

  $('.products .product').each(function(index, product) {
    refresh_ui($(product));
  })
  
});