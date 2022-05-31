# Defund validator node on Akash Network
# Нода валидатора сети Defund, развертка в Akash Network.
<div align="center">

![pba](https://user-images.githubusercontent.com/23629420/163564929-166f6a01-a6e2-4412-a4e9-40e54c821f05.png)
| [Akash Network](https://akash.network/) | [Forum Akash Network](https://forum.akash.network/) | 
|:--:|:--:|
___
Before you start - subscribe to our news channels: 

Прежде чем начать - подпишитесь на наши новостные каналы:

| [Discord Akash](https://discord.gg/3SNdg3BS) | [Telegram Akash EN](https://t.me/AkashNW) | [Telegram Akash RU](https://t.me/akash_ru) | [TwitterAkash](https://twitter.com/akashnet_) | [TwitterAkashRU](https://twitter.com/akash_ru) |
|:--:|:--:|:--:|:--:|:--:|

</div>
<div align="center">
  
| [Discord Defund](https://discord.gg/hXAU3Dgp) | [Explorer Defund](https://defund.explorers.guru/) | [Site Defund](https://www.defund.app/) | [Twitter Defund](https://twitter.com/defund_finance) |
|:--:|:--:|:--:|:--:|
  
</div>
<div align="center">
  
[English version](https://github.com/Dimokus88/oasys/blob/main/README.md#english-version) | [Русская версия](https://github.com/Dimokus88/defund#%D1%80%D1%83%D1%81%D1%81%D0%BA%D0%B0%D1%8F-%D0%B2%D0%B5%D1%80%D1%81%D0%B8%D1%8F)
  
</div>

# Русская версия
> Если хотите перенести вашу ноду на Akash, или у вас есть priv_validator_key.json, то перейдите [к этому пункту](https://github.com/Dimokus88/defund#2-%D0%B5%D1%81%D0%BB%D0%B8-%D1%83-%D0%B2%D0%B0%D1%81-%D0%B5%D1%81%D1%82%D1%8C-priv_validator_keyjson).

> На вашем кошельке ```Akash``` (с которого будет разворачивать ***Defund***) должно быть более ***5 АКТ*** (5 АКТ будут заблокированы на развертывание + оплата газа транзакций). АКТ можно пробрести на биржах ```Gate```, ```AsendeX```, ```Osmosis``` . Так же в нашем сообществе [Akash RU](https://t.me/akash_ru) мы регулярно проводим эвенты в которых раздаем АКТ.

## 1. Если запуск производится впервые:

***Создайте дополнительный кошелек экосистемы Cosmos для проекта Defund, с помощью Keplr или Cosmostation. Перепишите seed фразу от созданного кошелька, она понадобится нам при развертке.***

* Открываем ```Akashlytics```, если он у вас не установлен - то вот [ссылка на скачивание](https://www.akashlytics.com/deploy).

* Проверяем наличие баланса (>5АКТ) и наличие установленного сертификата.

![image](https://user-images.githubusercontent.com/23629420/165339432-6f053e43-4fa2-4429-8eb7-d2fc66f47c70.png)

* Нажимаем ```CREATE DEPLOYMENT```. Выбираем ```Empty```(пустой template) и копируем туда содержимое [deploy.yml](https://github.com/Dimokus88/defund/blob/main/deploy.yml) .

Давайте раберем что там есть, итак раздел ```services``` здесь указывается ```docker``` образ ноды, а также блок с переменными окружения ```env```:

В поле ***my_root_password*** - задаем пароль root для подключения по ssh.

В поле ***MONIKER*** - задаем имя ноды.

В поле ***MNEMONIС*** - вставляем мнемоник фразу от вашего кошелька ***Defund***.

В поле ***LINK_ADDRBOOK*** - ссылка на скачивание адресной книги пиров .

В поле ***SNAP_RPC*** - ссылка на ***RPC*** ноду, для начала синхронизации с последних блоков (рекомендуется) .

> Поле ***LINK_KEY*** -  оставьте закомментированным ссылка на размещенный priv_validator_key.json (прямое скачивание). Если у вас этого файла нет - закомментируйте строку символом # .

Ниже, в поле ```resources``` мы выставляем арендуюмую мощность. для ноды ***Defund*** рекомендуется ```2 CPU x 4 GB RAM x 300 GB SSD```. В случае синхронизации с ***RPC*** ноды - мы храним не полный блокчейн, поэтому можно поставить  ```2 CPU x 4 GB RAM x 100 GB SSD```. 

Нажимаем кнопку ```CREATE DEPLOYMENT``` и ждем появления провайдеров, со свободными мощностями (***BIDS***).

![image](https://user-images.githubusercontent.com/23629420/165608527-da85c84e-edcc-4b15-8843-441d3e76dcb6.png)


* Выбираем подходящий для нас по цене и оборудованию. После чего нажимаем ```ACCEPT BID```.

Ждем заверщения развертывания.

* Во вкладке ```LOGS``` дождитесь сообщения о сгенерированном файле ```priv_validator_key.json``` .

<div align="center">
  
![image](https://user-images.githubusercontent.com/23629420/171126372-81330266-8f01-47a9-a85e-68d1e2ada758.png)
  
</div>

* Во вкладке ```SHELL``` выполните команду ```cat /root/.defund/config/priv_validator_key.json```, ответ сохраните в файле ```priv_validator_key``` с расширением ```.json```.

<div align="center">
  
![image](https://user-images.githubusercontent.com/23629420/171126676-cf1a436e-ca56-43f6-ae53-66608d812534.png)
  
</div>

> Откройте доступ к файлу на ```google``` диск и скопируйте его ссылку, она будет вида:
```https://drive.google.com/open?id=xxxxxxxxxxxxxx-xxxxxxxxxxxx&authuser=gmail%40gmail.com&usp=drive_fs``
 вам нужно взять часть: ```id=xxxxxxxxxxxxxx-xxxxxxxxxxxx``` и вставить перед ней: ```https://drive.google.com/uc?export=download&```.  
Таким образом, у вас получится ссылка на прямое скачивание файла:
```https://drive.google.com/uc?export=download&id=xxxxxxxxxxxxxx-xxxxxxxxxxxx``` . Сохраните ее.

* Перейдите во вкладку ```UPDATE```, расскаментируйте строку  ***LINK_KEY*** (удалив символ #) и вставьте ссылку на прямое скачивание вашего файла ```priv_validator_key.json```. После чего нажмите ```UPDATE DEPLOYMENT```. Подтвердите транзакцию.

* В процессе работы будет выводится ваш адрес ***Defund***, на него нужно запросить токены. С краном все сложно, есть ресурс https://bitszn.com/faucets.html , может что то даст. Если нет - то идем в [дискорд](https://discord.gg/hXAU3Dgp) и просим токены на наш адрес Defund там.

<div align="center">
  
![image](https://user-images.githubusercontent.com/23629420/171135278-a5465f9e-8bab-4767-b724-120abde07bc1.png)
 
</div>

* В поле ```LOGS``` можете наблюдать работу ноды. Синхронизация начнеся с блока который на ***2000*** блоков "ниже" последнего. Например, если в сети на момент запуска ноды ***596562*** блоков, то синхронизивароться и "догонять" начнет с 596562-2000= ***594562*** блока. После полной синхронизации будет создан валидатор (если он не был созда ранее) и нода войдет в автоматический режим работы. Каждые  5 минут будет проверяться баланс, и в случае если он положителен - автоделегирование на себя. Так же будет происходить проверка на тюрьму, выход из тюрьмы будет выполнен автоматически.

[Перейти к началу](https://github.com/Dimokus88/defund#defund-validator-node-on-akash-network)

### Спасибо что используете Akash Network!

## 2. Если у вас есть priv_validator_key.json

> Откройте доступ к файлу на google диск и скопируйте его ссылку, она будет вида:
```https://drive.google.com/open?id=xxxxxxxxxxxxxx-xxxxxxxxxxxx&authuser=gmail%40gmail.com&usp=drive_fs```
 вам нужно взять часть: ```id=xxxxxxxxxxxxxx-xxxxxxxxxxxx``` и вставить перед ней: ```https://drive.google.com/uc?export=download&```.  
Таким образом, у вас получится ссылка на прямое скачивание файла:
```https://drive.google.com/uc?export=download&id=xxxxxxxxxxxxxx-xxxxxxxxxxxx``` . Сохраните ее.

* Открываем ```Akashlytics```, если он у вас не установлен - то вот [ссылка на скачивание](https://www.akashlytics.com/deploy).

* Проверяем наличие баланса (>5АКТ) и наличие установленного сертификата.

![image](https://user-images.githubusercontent.com/23629420/165339432-6f053e43-4fa2-4429-8eb7-d2fc66f47c70.png)

* Нажимаем ```CREATE DEPLOYMENT```. Выбираем ```Empty```(пустой template) и копируем туда содержимое [deploy.yml](https://github.com/Dimokus88/defund/blob/main/deploy.yml) .

Давайте раберем что там есть, итак раздел ```services``` здесь указывается ```docker``` образ ноды, а также блок с переменными окружения ```env```:

В поле ***my_root_password*** - задаем пароль root для подключения по ssh.

В поле ***MONIKER*** - указываем имя ноды.

В поле ***MNEMONIС*** - вставляем мнемоник фразу от вашего кошелька ***Defund***.

В поле ***LINK_KEY*** -  скопируйте ссылку на размещенный priv_validator_key.json (прямое скачивание). 

В поле ***LINK_ADDRBOOK*** - ссылка на скачивание адресной книги пиров .

В поле ***SNAP_RPC*** - ссылка на ***RPC*** ноду, для начала синхронизации с последних блоков (рекомендуется) .

Ниже, в поле ```resources``` мы выставляем арендуюмую мощность. для ноды ***Defund*** рекомендуется ```2 CPU x 4 GB RAM x 300 GB SSD```. В случае синхронизации с ***RPC*** ноды - мы храним не полный блокчейн, поэтому можно поставить  ```2 CPU x 4 GB RAM x 100 GB SSD```. 

Нажимаем кнопку ```CREATE DEPLOYMENT``` и ждем появления провайдеров, со свободными мощностями (***BIDS***).

![image](https://user-images.githubusercontent.com/23629420/165608527-da85c84e-edcc-4b15-8843-441d3e76dcb6.png)


* Выбираем подходящий для нас по цене и оборудованию. После чего нажимаем ```ACCEPT BID```.

Ждем заверщения развертывания.

* В вкладке ```LOGS``` можете наблюдать работу ноды. Синхронизация начнеся с блока который на ***2000*** блоков "ниже" последнего, например если в сети на момент запуска ноды ***596562*** блоков, то синхронизивароться и "догонять" начнет с 596562-2000= ***594562*** блока. После чего будет создан валидатор (если он не был созда ранее) и нода войдет в автоматический режим работы. Каждые  5 минут будет проверяться баланс, и в случае если он положителен - автоделегирование на себя. Так же будет происходить проверка на тюрьму, выход из тюрьмы будет выполнен автоматически.

* В процессе работы будет выводится ваш адрес ***Defund***, на него нужно запросить токены. С краном все сложно, есть ресурс https://bitszn.com/faucets.html , может что то даст. Если нет - то идем в [дискорд](https://discord.gg/hXAU3Dgp) и просим токены на наш адрес Defund там.

<div align="center">
  
![image](https://user-images.githubusercontent.com/23629420/171135278-a5465f9e-8bab-4767-b724-120abde07bc1.png)
 
</div>

[Перейти к началу](https://github.com/Dimokus88/defund#defund-validator-node-on-akash-network)

### Спасибо что используете Akash Network!
