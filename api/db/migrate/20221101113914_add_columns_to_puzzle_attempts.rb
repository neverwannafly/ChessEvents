class AddColumnsToPuzzleAttempts < ActiveRecord::Migration[6.1]
  def change
    add_column :puzzle_attempts, :time_taken, :integer
    add_column :puzzle_attempts, :status, :integer
    add_column :puzzle_attempts, :user_solution, :string
    add_column :puzzle_attempts, :rated, :boolean
    add_column :rating_changes, :volatility_change, :float

    change_column :rating_changes, :rating_change, :float
    change_column :rating_changes, :deviation_change, :float

    rename_column :puzzle_attempts, :user_id, :solver_id
  end
end
