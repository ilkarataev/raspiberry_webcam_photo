#!/bin/bash
File="/tmp/viewcam.jpg"
BotToken=""
chatid=""
# комманда отправки изображения
curl -s -X POST "https://api.telegram.org/bot"$BotToken"/sendPhoto" -F chat_id="$chatid" -F photo="@${File}"
 
# Не забываем, что для того, чтоб скрипт можно было запустить, надо изменить права доступа к нему, # добавив возможность исполнения файла, например командой
# chmod a+x script.sh
# Пример curl -s -X POST "https://api.telegram.org/bot<token>/sendPhoto" -F chat_id=<chatid> -F photo="@/path/to/your/photo.jpg"
 
