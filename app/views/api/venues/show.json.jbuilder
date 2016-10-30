json.extract! @venue, :id, :created_at, :updated_at, :phone, :website

json.delivery_info Miam::DELIVERY_INFO

json.product_groups @venue.product_groups.where(status: :live).order(order: :asc) do |product_group|
  json.(product_group, :label, :description, :status, :status, :order)
  
  json.products product_group.products.where(status: :live).order(order: :asc) do |product|
    json.(product, :id, :label, :description, :base_price)
    
    json.product_variations product.product_variations do |product_variation|
      json.(product_variation, :id, :label, :allow_multi_choices, :multi_choice_limit)

      json.variation_options product_variation.variation_options do |variation_option|
        json.(variation_option, :id, :label, :allow_multi_choices, :multi_choice_limit, :price_variation)
      end
    end
  end
end