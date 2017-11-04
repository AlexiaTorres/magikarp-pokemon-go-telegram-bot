every :day, at: '23:00pm' do
  rake 'user_coins:verify_coins', output: 'log/whenever.user_coins.log'
end
