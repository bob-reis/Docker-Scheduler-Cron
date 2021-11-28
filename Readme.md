## Scheduler para tarefas agendadas

Este container tem o papel de rodar tarefas agendadas, como rsync, backups, etc

A função é rodar o cron e o supervisor para encapsular tarefas que podem eventualmente causar problemas de desempenho ou até controlar estes processos

Para criar a imagem execute: `docker build -t [nome da imagem:versao] .`

### Modo de Usar
Você pode criar qualquer tarefa no cron apenas editando o arquivo: `./cron.job`

Para garantir o funcionamento disto, o container usa o supervisor, você pode criar novas funções ou chamar novas aplicações também utilizando ele, basta editar o arquivo: `./supervisor-api.conf`

Caso queira inserir algum script, adicione-o a pasta `./scripts`, você poderá chama-lo no cron pelo caminho: `/opt/scripts/[seu-script.sh]`

Lembre de por garantia, antes de chamar o script colocar sempre a permissão de execução, veja abaixo um exemplo de entrada de cron com script:

`00 04 * * * chmod +x /opt/scripts/backup.sh|/opt/scripts/backup.sh`

Caso você queira persistir algum log dos seus agendamentos, você pode direciona-los para `/var/log/schedule/`, ele salvará no disco do host no caminho `./Logs`

#### Executando o Docker
Para executar o container mapeando externamente os arquivoscom o docker compose:
 
 `docker compose up -d`
