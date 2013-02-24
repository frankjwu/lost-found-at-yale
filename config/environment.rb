# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
LostFound::Application.initialize!

CASClient::Frameworks::Rails::Filter.configure(
  :cas_base_url => "https://secure.its.yale.edu/cas/",
  :username_session_key => :cas_user,
  :extra_attributes_session_key => :cas_extra_attributes
)

credentials = YAML.load_file("#{Rails.root}/config/credentials.yml")
ENV['CAS_NETID'] = credentials['username']
ENV['CAS_PASS'] = credentials['password']