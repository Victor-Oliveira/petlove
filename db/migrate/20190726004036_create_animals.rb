class CreateAnimals < ActiveRecord::Migration[5.2]
  def change
    create_table :animals do |t|
      t.string  :name
      t.decimal :monthly_cost, precision: 10, scale: 2

      t.belongs_to :person, index: true
      t.belongs_to :animal_type, index: true

      t.timestamps
    end
  end
end
