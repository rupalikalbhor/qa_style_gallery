require 'yajl'
require 'json'

def get_file(filename)
  File.join(File.dirname(__FILE__), '', filename)
end

SignInUserData = get_file('sign_in_user_data.json')
FacebookUserData =  get_file('facebook_user.json')

def parse_json_data(path)
  json = File.new(path, 'r')
  hash = Yajl::Parser.new
  hash.parse(json)
end

def get_sign_in_user_data
  @sign_in_user_data ||= parse_json_data(SignInUserData)
end

def get_facebook_user_data
  @facebook_user_data ||= parse_json_data(FacebookUserData)
end

def write_json_data(path,tempHash)
  File.open(path, 'w')do |f|
    #f.write(JSON.pretty_generate(tempHash))
    f.write(tempHash.to_json)
  end
end