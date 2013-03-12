def get_latest_tab_user_details
  outfit_id,love_count,moderated_at,firstname, lastname, personal_website_url = connection(:query_name => :most_loved_This_week_outfit_details)

  return outfit_id,love_count, personal_website_url, firstname, lastname, moderated_at
end