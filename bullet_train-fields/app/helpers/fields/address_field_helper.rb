module Fields::AddressFieldHelper
  def populate_country_options
    ([Addresses::Country.find_by(name: "United States"), Addresses::Country.find_by(name: "Canada")] + Addresses::Country.all).map { |country| [country.name, country.id] }.uniq
  end

  def populate_region_options(address_form)
    return [] if address_form.object.country_id.nil?
    Addresses::Region.where(country_id: address_form.object.country_id).map { |region| [region.name, region.id] }
  end
  
  def admin_division_label_for(address_form)
    admin_divisions_key = if address_form.object.country_id.presence
      country = Addresses::Country.find(address_form.object.country_id)
      country.admin_divisions.presence || "default"
    else
      "default"
    end
    path = [:addresses, :fields, :admin_divisions, admin_divisions_key]
    t(path.compact.join("."))
  end
  
  def postal_code_label_for(address_form)
    key = if address_form.object.country_id == 233
      :zip_code 
    else
      :postal_code
    end
    path = [:addresses, :fields, key, :label]
    t(path.compact.join("."))
  end
end