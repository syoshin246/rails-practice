class CreateBoards < ActiveRecord::Migration[7.0]
  def change
    create_table :boards do |t|
      t.string :title 
      t.string :title2 
      t.text :description
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
