FROM debian:latest

RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

RUN apt -y update
RUN apt -y upgrade
RUN apt -y install ntpdate locales wget curl procps vim cron rsync ssh-client

RUN rm /etc/locale.gen
COPY ./locale.gen /etc/
RUN locale-gen pt_BR.utf8

ENV LC_ALL pt_BR.UTF-8
ENV LANG pt_BR.UTF-8
ENV LANGUAGE pt_BR.UTF-8
ENV TZ America/Sao_Paulo

RUN apt -y install supervisor
COPY ./supervisor.conf /etc/supervisor/conf.d/
COPY ./cron.conf /etc/supervisor/conf.d/.
COPY ./cron.job /etc/cron.d/.
RUN chmod 0644 /etc/cron.d/cron.job
RUN crontab /etc/cron.d/cron.job
RUN touch /var/log/cron.log

RUN mkdir -p /opt/scripts/
RUN mkdir -p /var/log/scheduler

ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c",  "/etc/supervisor/supervisord.conf"]

