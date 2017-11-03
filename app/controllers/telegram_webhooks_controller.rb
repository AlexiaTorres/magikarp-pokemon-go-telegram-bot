class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  def start(*)
    respond_with :message, text: t('.content')
  end

  def register(name = nil, *)
    if name
      if name.downcase == 'gyarados'
        respond_with :message, text: t('.gyarados')
      elsif User.where(id: chat["id"]).exists?
        respond_with :message, text: t('.register_yet')
      elsif User.where(username: name).exists?
        respond_with :message, text: t('.name_unavailable')
      else
        add_user name, chat["id"]
        respond_with :message, text: t('.register_ok')
      end
    else
      save_context :register
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
