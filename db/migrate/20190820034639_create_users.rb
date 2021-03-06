class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, id: :uuid, default: -> { "uuid_generate_v4()" } do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :display_name

      t.timestamps
    end
  end
end
