class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :fromid
      t.integer :toid
      t.text :content

      t.timestamps
    end
  end
end
