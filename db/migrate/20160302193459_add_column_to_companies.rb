class AddColumnToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :name, :string
    add_column :companies, :price, :string
    add_column :companies, :telephone, :string
    add_column :companies, :position, :string
  end
end
