class AddFamilyToEvents < ActiveRecord::Migration[6.0]
  def change
    add_reference :events, :family, null: false, foreign_key: true
  end
end
