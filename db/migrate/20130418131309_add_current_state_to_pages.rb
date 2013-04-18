class AddCurrentStateToPages < ActiveRecord::Migration
  def change
    add_column :pages, :current_state, :integer
    remove_column :pages, :published
  end
end
