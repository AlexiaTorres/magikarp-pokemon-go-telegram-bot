class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  def start(*)
    respond_with :message, text: t('.content')
  end

  def register(name = nil, *)
    if name
      if name.downcase == 'gyarados'
        bot.send_photo(chat_id: chat['id'], photo: 'https://img00.deviantart.net/0c24/i/2011/090/b/b/magikarp_by_isa81-d3cw86v.png')
        respond_with :message, text: t('.gyarados')
      elsif User.where(id: chat["id"]).exists?
        respond_with :message, text: t('.register_yet')
      elsif User.where(username: name).exists?
        respond_with :message, text: t('.name_unavailable')
      else
        add_user name, chat["id"]
        respond_with :message, text: t('.register_ok', name: name)
      end
    else
      save_context :register
      respond_with :message, text: t('.content')
    end
  end

  def start_coins(coins = nil, *)
    if coins
      @user = User.find(from['id'])
      @user.coins = coins
      @user.save
      bot.send_photo(chat_id: chat['id'], photo: 'https://orig00.deviantart.net/ce29/f/2011/097/7/e/magikarp_for_collab_by_kayleigh29-d3dh6u8.png')
      respond_with :message, text: t('.start_coins', coins: coins)
    else
      save_context :start_coins
      respond_with :message, text: t('.content')
    end
  end

  def my_coins(*)
    coins = User.find(from['id']).coins
    respond_with :message, text: t('.my_coins', coins: coins)
  end

  def update_coins(coins = nil, *)
    if coins
      @user = User.find(from['id'])
      @user.coins += coins.to_i
      @user.save
      respond_with :message, text: t('.update_coins', coins: coins)
    else
      save_context :update_coins
      respond_with :message, text: t('.content')
    end
  end

  # This will call #register like if it is called with message '/register %text%'
  # If you have a lot of such methods you can use
  context_to_action!
  # It'll use context value as action name for all contexts which miss handlers.

  def add_user (name, user_id)
    @user = User.new(username: name, id: user_id)
    @user.save
  end

end
