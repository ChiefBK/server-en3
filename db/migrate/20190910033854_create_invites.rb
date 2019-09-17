class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
