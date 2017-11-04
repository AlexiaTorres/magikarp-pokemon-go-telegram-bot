class User < ApplicationRecord

  def update_coins(chat_id)
    Telegram.bot.send_message chat_id: chat_id, text: '¿Cuántas monedas habéis recibido hoy? Click en /update_coins para registrarlas. También podéis escribirlo /update_coins y seguido el número de monedas recibidas. Por ejemplo: /update_coins 50'
  end
end
