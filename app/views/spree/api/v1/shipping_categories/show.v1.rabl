object @shipping_category
cache [I18n.locale, @current_user_roles.include?('admin'), current_currency, root_object]

attributes :id, :name

child :shipping_methods => :shipping_methods do
  attributes :id, :name, :display_on, :tracking_url, :admin_name, :tax_category_id, :code
end
