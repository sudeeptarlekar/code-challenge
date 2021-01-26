class AddStateAndCityToCompany < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :state_name, :string
    add_column :companies, :city, :string
  end
end
