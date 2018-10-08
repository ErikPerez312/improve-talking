class CreateAvailableUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :available_users do |t|

      t.timestamps
    end
  end
end
