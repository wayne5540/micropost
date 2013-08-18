class CreateTheMicroposts < ActiveRecord::Migration
  def change
    create_table :the_microposts do |t|
      t.string :content
      t.integer :user_id

      t.timestamps
    end
    add_index :the_microposts, [:user_id, :created_at]
  end
end
