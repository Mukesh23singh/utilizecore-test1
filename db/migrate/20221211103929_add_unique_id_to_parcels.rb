class AddUniqueIdToParcels < ActiveRecord::Migration[6.1]
  def change
    add_column :parcels, :unique_id, :string
  end
end
