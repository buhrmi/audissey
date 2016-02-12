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
    formatted = Price::CURRENCIES[price.currency][:symbol] + number_with_delimiter(price.take) + ' ' + price.currency
    if price.give && price.give > 1
      "#{price.give} for #{formatted}"
    else
      formatted
    end
  end
  
  def message_classes(message, user)
    if message.sender_id.nil?
      'system'
    elsif message.sender_id == user.id
      'sent'
    else
      'received'
    end
  end
  
  def event_date(date)
    # TODO: show time slot on event's time zone (day, night, evening, morning)
    date.strftime(t 'date.formats.short') + ' (' + t("date.abbr_day_names")[date.wday] + ')'
  end
  
end
