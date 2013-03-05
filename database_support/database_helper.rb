require 'postgres'
require 'capybara_support/configuration'

def connection(options)
  query_name = options[:query_name] || :UserDetails

  get_environment()
  @port_number = 5432

  @conn = PGconn.connect(@ip_address, @port_number, '', '', @database_name, @user_name, @password)

  sql = query_collection(query_name)
  if sql.nil?
    return ''
  end

  result_set = @conn.exec(sql)
  output = query_result(query_name, result_set)
  @conn.close()
  return output
end

private
def get_environment
  case $environment
    when :stage
      @ip_address = ""
      @user_name = ""
      @password = ""

    when :production
      @ip_address = ""
      @user_name = ""
      @password = ""

    when :preview
      @ip_address = ""
      @user_name = ""
      @password = ""

    when :demo
      @ip_address = '192.168.113.9'
      @database_name = 'community_demo'
      @user_name = 'postgres'
      @password = '6VrgPkuImN9bGP9ztIhO'
  end
  #@url = CapybaraSupport::Configuration.get_environment_url
end

private
def query_collection(query_name)
  case query_name
    when :UserDetails
      puts "running sql"
      sql = "SELECT id, created_at, updated_at, firstname, lastname, email, personal_website_url
             FROM cached_accounts where email = 'r.kalbhor@modcloth.com'"

    #when :Voting_in_progress_SampleCount
    #  sql = "SELECT count(*)
    #         FROM samples
    #         WHERE state ='active' AND (voting_starts_at <= now() AND voting_ends_at > now())"
    #

    else
      print "\n No matching query..Please check your typos.... \n"
      sql = nil
  end
  return sql
end

private
def query_result(query_name, res)
  case query_name
    when :UserDetails
      id = res.getvalue(0, 0)
      created_date = res.getvalue(0, 1)
      updated_at = res.getvalue(0, 2)
      firstname = res.getvalue(0, 3)
      lastname = res.getvalue(0, 4)
      email = res.getvalue(0, 5)
      website = res.getvalue(0, 6)

    puts "Sample name is ****************- #{id}"
    puts "Sample price is ****************- #{created_date}"
    puts "Vote count is ****************- #{updated_at}"
    puts "voting time is ****************- #{firstname}"
    puts "voting ends at is ****************- #{lastname}"
      puts "voting ends at is ****************- #{email}"
      puts "voting ends at is ****************- #{website}"
    else
      value = res.getvalue(0, 0)
      return value
  end
end