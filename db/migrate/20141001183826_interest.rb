class Interest < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :interest_type
      t.string :details
      t.integer :sentiment
      t.integer :user_id
    end
  end
end
