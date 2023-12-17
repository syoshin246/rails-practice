class Addaa < ActiveRecord::Migration[7.0]
  def change
    add_column :boards, :title2, :string
  end
end
# migrate更新 docker-compose exec web bundle exec rails db:migrate