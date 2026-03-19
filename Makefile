DB_VOLUME_PATH	= /home/$(USER)/data/mariadb
WP_VOLUME_PATH	= /home/$(USER)/data/wordpress
COMPOSE_FILE	= srcs/docker-compose.yml

all: up

build:
	mkdir -p $(DB_VOLUME_PATH)
	mkdir -p $(WP_VOLUME_PATH)
	docker compose -f $(COMPOSE_FILE) build

up:
	mkdir -p $(DB_VOLUME_PATH)
	mkdir -p $(WP_VOLUME_PATH)
	docker compose -f $(COMPOSE_FILE) up -d

down:
	docker compose -f $(COMPOSE_FILE) down

stop:
	docker compose -f $(COMPOSE_FILE) stop

clean: down
	docker compose -f $(COMPOSE_FILE) down --rmi all --volumes
	sudo rm -rf $(DB_VOLUME_PATH)
	sudo rm -rf $(WP_VOLUME_PATH)
	docker system prune -af

re: clean all

.PHONY: all build up down stop clean re