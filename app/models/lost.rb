class Lost < ActiveRecord::Base
  attr_accessible :desc, :tag_list
  validates :desc, presence: true

  EXTRA_WORDS = ["a", "the", "and", "for", "in", "is", "are", "am",
  	"I", "we", "of", "it", "he", "she", "we", "this", "with", "that",
  	"so", "as"]

  acts_as_taggable

  def remove_extra
  	new_tags = Array.new
  	old_tags = self.tag_list # get old tags
  	old_tags.each do |tag|
  		unless EXTRA_WORDS.include?(tag)
  			new_tags << tag
  		end
  	end
  	self.tag_list = new_tags
  	self.save
  end

  def parse_desc
  	tags = self.desc.downcase.split(" ")
  	self.tag_list = tags
  	self.save
  end

end
