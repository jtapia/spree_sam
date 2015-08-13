Spree.user_class.class_eval do
  scope :new_users_daily_at, -> (starting_at, ending_at) {
    select("count(1) count")
        .where('created_at between ? and ?', starting_at, ending_at)
  }
end