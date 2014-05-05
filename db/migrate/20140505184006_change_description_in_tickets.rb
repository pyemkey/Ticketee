class ChangeDescriptionInTickets < ActiveRecord::Migration
  def change
    change_column :tickets, :description, :text
  end
end
