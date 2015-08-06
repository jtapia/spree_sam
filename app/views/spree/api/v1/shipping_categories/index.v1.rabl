object false
node(:count) { @shipping_categories.count }
node(:total_count) { @shipping_categories.total_count }
node(:current_page) { params[:page] ? params[:page].to_i : 1 }
node(:per_page) { params[:per_page] || Kaminari.config.default_per_page }
node(:pages) { @shipping_categories.num_pages }
child(@shipping_categories => :shipping_categories) do
  extends "spree/api/v1/shipping_categories/show"
end
