module Spree
  module Api
    module V1
      class StatsController < Spree::Api::BaseController
        before_action :check_params

        def index
          render json: {
                     stats: {
                         orders: orders_stats,
                         users: users_stats
                     }
                 }
        end

        private

        def check_params
          params[:from] ||= 10
          params[:until] ||= 1
        end

        def orders_stats
          stats = {guest_orders: [], orders: [], abandoned_orders: []}
          params[:from].downto(params[:until]).each do |day|
            day = day.days.ago

            guest = Spree::Order.daily_guest_sales_at(day.beginning_of_day, day.end_of_day)[0]
            stats[:guest_orders] << {day: day, total: guest.try(:total), count: guest.try(:count), avg: guest.try(:avg)}

            orders = Spree::Order.daily_non_guest_sales_at(day.beginning_of_day, day.end_of_day)[0]
            stats[:orders] << {day: day, total: orders.try(:total), count: orders.try(:count), avg: orders.try(:avg)}

            churn_orders = Spree::Order.churn_orders_daily_at(day.beginning_of_day, day.end_of_day)[0]
            stats[:abandoned_orders] << {day: day, total: churn_orders.try(:total), count: churn_orders.try(:count), avg: churn_orders.try(:avg)}
          end
          stats
        end

        def users_stats
          stats = {new_users: []}
          params[:from].downto(params[:until]).each do |day|
            day = day.days.ago

            new_users = Spree.user_class.new_users_daily_at(day.beginning_of_day, day.end_of_day)[0]
            stats[:new_users] << {day: day, count: new_users.count}
          end
          stats
        end
      end
    end
  end
end