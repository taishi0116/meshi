class CreateInvites < ActiveRecord::Migration[5.2]
  def change
    create_table :invites do |t|
      t.integer :fromid
      t.text :content, null: false
      t.text :title, null: false

      t.timestamps
    end
  end
end
