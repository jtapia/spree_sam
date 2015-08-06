module Spree
  module Api
    module V1
      class ShippingCategoriesController < Spree::Api::BaseController

        def index
          @shipping_categories = Spree::ShippingCategory.all.includes(:shipping_methods).page(params[:page]).per(params[:per_page])
        end

        def show
          @shipping_category = Spree::ShippingCategory.find(params[:id])
        end
      end
    end
  end
end