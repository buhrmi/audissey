module ApplicationHelper
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to(name, '#', :class => "add_fields", :data => {:id => id, :fields => fields.gsub("\n", "")})
  end

  def nice_price(price)
    price = Price.new(price) if price.is_a?(Hash)
    formatted = number_to_currency(price.take, :unit => Price::CURRENCIES[price.currency][:symbol]) + ' ' + price.currency
    if price.give && price.give > 1
      "#{price.give} for #{formatted}"
    else
      formatted
    end
  end
end
