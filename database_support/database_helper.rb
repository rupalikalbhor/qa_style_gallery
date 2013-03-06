require 'postgres'

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
end

private
def query_collection(query_name)
  case query_name
    when :latest_tab_outfit_details
      sql = "select o.id, o.loves_count, o.moderated_at, ca.firstname, ca.lastname, ca.personal_website_url
             FROM outfits o FULL OUTER JOIN cached_accounts ca
             ON o.account_id = ca.id
             WHERE o.state= 'approved' Order by o.moderated_at DESC limit 1"

    when :featured_tab_outfit_details
      sql = "select o.id, o.loves_count, o.moderated_at, ca.firstname, ca.lastname, ca.personal_website_url
             FROM outfits o FULL OUTER JOIN cached_accounts ca
             ON o.account_id = ca.id
             WHERE o.state= 'approved'
             AND o.featured = 't' Order by o.moderated_at DESC limit 1"

    when :most_loved_All_time_tab_outfit_details
      sql = "select o.id, o.loves_count, o.moderated_at, ca.firstname, ca.lastname, ca.personal_website_url
             FROM outfits o FULL OUTER JOIN cached_accounts ca
             ON o.account_id = ca.id
             WHERE o.state= 'approved'
             Order by o.loves_count DESC, o.moderated_at DESC limit 1"

    when :most_loved_This_week_outfit_details
      sql = "select o.id, age(current_timestamp, o.moderated_at), o.loves_count, ca.firstname, ca.lastname, ca.personal_website_url
            FROM outfits o FULL OUTER JOIN cached_accounts ca
            ON o.account_id = ca.id
            WHERE o.state= 'approved'
            AND o.loves_count >=1 and age(o.moderated_at) < '7 days 00:00:00.000000' limit 1"

    when :most_loved_Today_outfit_details
      sql = "select o.id, age(current_timestamp, o.moderated_at), o.loves_count, ca.firstname, ca.lastname, ca.personal_website_url
            FROM outfits o FULL OUTER JOIN cached_accounts ca
            ON o.account_id = ca.id
            WHERE o.loves_count >=1 and age(current_timestamp, o.moderated_at) < '24:00:00.000000'"

    #when :UserDetails
    #  sql = "select o.id, o.loves_count, o.moderated_at, ca.firstname, ca.lastname, ca.personal_website_url
    #  FROM outfits o FULL OUTER JOIN cached_accounts ca
    #  ON o.account_id = ca.id
    #  WHERE o.account_id  = ca.id and o.id = 141"

    when :OutfitDetailPage
      sql = "select o.id, o.loves_count, o.moderated_at, oi.product_id, oi.pictured
      FROM outfits o FULL OUTER JOIN outfit_items oi
      ON o.id = oi.outfit_id
      WHERE o.id  = oi.outfit_id and o.id = 141"

    else
      print "\n No matching query..Please check your typos.... \n"
      sql = nil
  end
  return sql
end

private
def query_result(query_name, res)
  case query_name
    when :latest_tab_outfit_details
      outfit_id = res.getvalue(0, 0)
      love_count = res.getvalue(0, 1)
      moderated_at = res.getvalue(0, 2)
      firstname = res.getvalue(0, 3)
      lastname = res.getvalue(0, 4)
      personal_website_url = res.getvalue(0, 5)

      #puts "outfit id is ****************- #{firstname}"
      #puts "love count is ****************- #{lastname}"
      #puts "moderated at is ****************- #{personal_website_url}"
      #puts "first name is ****************- #{firstname}"
      #puts "last name is ****************- #{lastname}"
      #puts "personal website url is ****************- #{personal_website_url}"

      return outfit_id,love_count,moderated_at,firstname, lastname, personal_website_url
    else
      value = res.getvalue(0, 0)
      return value
  end
end