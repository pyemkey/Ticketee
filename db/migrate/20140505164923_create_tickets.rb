class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.string :description
      t.belongs_to :project, index: true

      t.timestamps
    end
  end
end
