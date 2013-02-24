class Found < ActiveRecord::Base
  attr_accessible :date, :desc, :location, :image
  validates :date, :desc, :location, :image, presence: true

  belongs_to :user

  acts_as_taggable
  mount_uploader :image, ImageUploader

  def parse_desc
  	tags = self.desc.downcase.split(" ")
  	self.tag_list = tags
  	self.save
  end
  
end
