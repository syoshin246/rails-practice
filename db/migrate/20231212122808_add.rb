class Add < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :title2, :string
  end
end
