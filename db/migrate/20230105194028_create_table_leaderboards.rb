class CreateTableLeaderboards < ActiveRecord::Migration[7.0]
  def change
    create_table :leaderboards, id: :uuid do |t|
      t.string :username
      t.string :game_session_id
      t.integer :duration
      t.integer :level
      t.timestamps
    end

    add_index :leaderboards, :game_session_id, unique: true
  end
end
