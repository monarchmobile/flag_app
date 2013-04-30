class AddHostStateAndHostCountryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :host_state, :string
    add_column :users, :host_country, :string
  end
end
