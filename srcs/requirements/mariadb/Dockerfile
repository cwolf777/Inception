FROM debian:bookworm

RUN apt-get update && apt-get install -y mariadb-server

RUN mkdir -p /run/mysqld
RUN chown -R mysql:mysql /run/mysqld

#copy config
COPY conf/my.cnf /etc/mysql/my.cnf

#setup skript kopieren
COPY tools/setup.sh /setup.sh

#skript ausführbar machen
RUN chmod +x /setup.sh

EXPOSE 3306

CMD ["/setup.sh"]