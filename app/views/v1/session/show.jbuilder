json.session do
  json.authentication_token current_user.authentication_token
  json.gender current_user.gender
  json.email current_user.email
  json.user_name current_user.user_name
end