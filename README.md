# vscode-server [Dokploy](https://dokploy.com/)

Dockerfile запускает следующий код по [документации](https://coder.com/docs/code-server/install)
```
curl -fOL https://github.com/coder/code-server/releases/download/v$VERSION/code-server_${VERSION}_amd64.deb
sudo dpkg -i code-server_${VERSION}_amd64.deb
sudo systemctl enable --now code-server@$USER
```
Инструкция для Dokploy:

1. Создать репозиторий vscode-server (клонировать)
2. Создать новый проект/сервис, например под именем vscode
3. [Узнать последнюю версию релиза](https://github.com/coder/code-server), например 4.93.1
4. Записать в Environment Settings:
   ```
   VERSION=4.93.1
   ```
6. Задеплоить Repository vscode-server из Github, Branch main, Build Path /
7. Посмотреть пароль с помощью команды из терминала во вкладке General - Open Terminal:
   
```
cat /home/code-server-user/.config/code-server/config.yaml
```
8. config.yaml содержит следующие данные:
    
```
bind-addr: 127.0.0.1:8080
auth: password
password: f9de8c48570ab3c1d7461100
cert: false
```
9. Скопировать password в Environment Settings
   ```
   PASSWORD=f9de8c48570ab3c1d7461100 (Изменен :))
   ```
10. Создать домен с портом 8080
11. Зайти на домен и ввести пароль (Ранее созданный, а в config.yaml уже будет другой). 
