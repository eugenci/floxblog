class ChangePostToHaveMandatoryTitleAndMandatoryContent < ActiveRecord::Migration
  def change
    change_column :posts, :title, :string, null: false
    change_column :posts, :content, :text, null: false
  end
end
