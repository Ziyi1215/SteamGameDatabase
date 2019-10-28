class CreateSupports < ActiveRecord::Migration[5.1]
  def change
    create_table :supports do |t|
      t.belongs_to :language, index: true
      t.belongs_to :game, index: true

      t.timestamps
    end
  end
end
