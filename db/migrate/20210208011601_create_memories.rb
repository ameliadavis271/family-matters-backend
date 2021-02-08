class CreateMemories < ActiveRecord::Migration[6.0]
  def change
    create_table :memories do |t|
      t.string :name
      t.text :description
      t.references :family, null: false, foreign_key: true

      t.timestamps
    end
  end
end
