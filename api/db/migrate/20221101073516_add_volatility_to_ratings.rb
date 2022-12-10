class AddVolatilityToRatings < ActiveRecord::Migration[6.1]
  def change
    add_column :ratings, :volatility, :float, default: 0.06
    change_column :ratings, :rating_deviation, :float, default: 350.0
    change_column :ratings, :rating, :float, default: 1500.00
  end
end
