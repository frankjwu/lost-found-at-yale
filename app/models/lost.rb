class Lost < ActiveRecord::Base
  attr_accessible :desc, :tag_list
  validates :desc, presence: true

  acts_as_taggable

  def parse_desc
  	tags = self.desc.split(" ")
  	self.tag_list = tags
  	self.save
  end

end
