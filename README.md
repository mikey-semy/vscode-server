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
   PASSWORD=<Ваш пароль>
   ```
5. Задеплоить Repository vscode-server из Github, Branch main, Build Path /
6. Создать домен с портом 8080
7. Зайти на домен и ввести пароль <Ваш пароль>. 
