class Found < ActiveRecord::Base
  attr_accessible :date, :desc, :location
  validates :date, :desc, :location, presence: true

  acts_as_taggable

  def parse_desc
  	tags = self.desc.downcase.split(" ")
  	self.tag_list = tags
  	self.save
  end
  
end
