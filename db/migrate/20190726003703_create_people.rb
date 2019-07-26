class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name
      t.string :paper_number
      t.date   :birth_date

      t.timestamps
    end
  end
end
