class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :authentication_token
      t.timestamps null: false
    end
  end
end
