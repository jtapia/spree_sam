Spree::Order.class_eval do

  scope :daily_guest_sales_at, -> (starting_at, ending_at) {
    select("sum(total) total, count(1) count, avg(total) avg")
        .complete
        .where('completed_at between ? and ?', starting_at, ending_at)
        .where(user_id: nil)
  }

  scope :daily_non_guest_sales_at, -> (starting_at, ending_at) {
    select("sum(total) total, count(1), avg(total) avg")
        .complete
        .where('completed_at between ? and ?', starting_at, ending_at)
        .where.not(email: nil)
  }

  scope :churn_orders_daily_at, -> (starting_at, ending_at) {
    select("sum(total) total, count(1), avg(total) avg")
        .where(completed_at: nil)
        .where('updated_at between ? and ?', starting_at, ending_at)
        # .where.not(email: nil)
  }

end