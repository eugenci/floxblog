class Post < ActiveRecord::Base
  validates_presence_of   :title, :content, :user
  validates_uniqueness_of :title

  belongs_to :user
end
