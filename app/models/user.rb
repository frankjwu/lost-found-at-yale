# credit to Zack Reneau-Wedeen
# https://gist.github.com/zackrw/3794895

require 'mechanize'
 
class User < ActiveRecord::Base
  KNOWN_AS = /^\s*Known As:\s*$/i
  EMAIL = /^\s*Email Address:\s*$/i
  YEAR = /^\s*Class Year:\s*$/i
  SCHOOL = /^\s*Division:\s*$/i
  COLLEGE = /^\s*Residential College:\s*$/i
  LEAD_SPACE = /^\s+/
  TRAIL_SPACE = /\s+$/
 
  before_validation :repair

  has_many :founds
 
  validates_uniqueness_of :email, :message => 'email address conflicts'
  validates_uniqueness_of :netid, :message => 'netid conflicts'
 
  def make_cas_browser
    browser = Mechanize.new
    browser.get( 'https://secure.its.yale.edu/cas/login' )
    form = browser.page.forms.first
    form.username = ENV['CAS_NETID']
    form.password = ENV['CAS_PASS']
    form.submit
    browser
  end
 
  # update a user with the any extra available info from the yale directory
  def repair
    user_hash = self.get_user
    self.merge user_hash
  end
 
 
  def get_user
    browser = make_cas_browser
    netid = self.netid
    user_hash = {}
 
    browser.get("http://directory.yale.edu/phonebook/index.htm?searchString=uid%3D#{netid}")
 
    browser.page.search('tr').each do |tr|
      field = tr.at('th').text
      value = tr.at('td').text.sub(LEAD_SPACE, '').sub(TRAIL_SPACE, '')
      case field
      when KNOWN_AS
        user_hash[:fname] = value
      when EMAIL
        user_hash[:email] = value
        name = name_from_email(value)
        user_hash[:given_name] = name[:first]
        user_hash[:lname] = name[:last]
      when YEAR
        year = value.to_i
        user_hash[:year] = year != 0 ? year : nil
      when SCHOOL
        user_hash[:school] = value
      when COLLEGE
        user_hash[:college] = value
      end
    end
 
    # Use the name we got from the email if there is no "Known As" field.
    if user_hash[:given_name] && !user_hash[:fname]
      user_hash[:fname] = user_hash[:given_name]
    end
 
    user_hash
  end
 
  def merge(hash) # non-greedy merge for the user
    hash.each do |key, val|
      self[key] = val unless self[key]
    end
  end
end