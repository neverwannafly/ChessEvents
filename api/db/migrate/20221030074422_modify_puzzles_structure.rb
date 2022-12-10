class ModifyPuzzlesStructure < ActiveRecord::Migration[6.1]
  def change
    remove_index :puzzles, column: [:rating], name: "index_puzzles_on_rating"
    remove_column :puzzles, :rating
    remove_column :puzzles, :rating_deviation

    remove_index :ratings, column: [:user_id], name: "index_ratings_on_user_id"
    remove_column :ratings, :user_id
    add_column :ratings, :owner_type, :string
    add_column :ratings, :owner_id, :integer
    add_column :ratings, :rating_deviation, :integer

    add_index :ratings, %i[owner_type owner_id]
    add_index :ratings, :rating

    create_table :rating_changes do |t|
      t.references :rating
      t.string :target_type
      t.integer :target_id
      t.integer :rating_change
      t.integer :deviation_change

      t.timestamps
    end

    create_table :puzzle_attempts do |t|
      t.string :solver_type
      t.integer :solver_id
      t.references :puzzle
      # Add more fields as necessary later
    end

    add_index :puzzle_attempts, %i[solver_type solver_id]

    add_index :rating_changes, %i[target_type target_id]
  end
end
