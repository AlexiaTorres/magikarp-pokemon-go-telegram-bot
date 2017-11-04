namespace :user_coins do

  desc 'Verify recolected coins of day'
  task verify_coins: :environment do
    puts "Verificando monedas recibidas durante el día..."
    User.all.each do |u|
      u.update_coins(u.id)
    end
    puts "Listo!"
  end
end