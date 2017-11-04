# README

## Create your bot on telegram app
Go to Telegram app and search BotFather and talk him.
Use the /newbot command to create a new bot. BotFather will ask you for a name and username, then generate an authorization token for your new bot.

Your bot's username must end in ‘bot’, e.g. ‘magikarp_bot’ or ‘MagikarpBot’.

The token is a string along the lines of 110201543:AAHdqTcvCH1vGWJxfSeofSAs0K5PALDsaw that is required to authorize the bot and send requests to the Bot API.

## Configuration

Copy *app/config/secrets.example* into new file *app/config/secrets.yml* and fill it with your data

```$ bundle install```

Create the database, i did it in phpmyadmin. Then go to *app/config/database.example* and copy to new file *app/config/database.yml*. After do it, fill the file with your database data.

```$ rails db:migrate```

## How it works

All the functionality is between *controller/TelegramWebhooksController* and *config/locales*

TelegramWebhooksController methods are the /actions on the telegram chat: /start, /register...

Your bot can send messages with text or photos, I only implemented photos by url, not by file.

See more on telegram-bot-rb gem documentation:
https://github.com/telegram-bot-rb/telegram-bot

## Run

```rake telegram:bot:poller```
