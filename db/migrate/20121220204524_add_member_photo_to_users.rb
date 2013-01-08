class AddMemberPhotoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :member_photo, :string
  end
end
