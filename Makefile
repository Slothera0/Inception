D_MARIADB = "/home/arvoyer/data/mariadb"
D_WORDPRESS = "/home/arvoyer/data/wordpress"

DOCKER_COMPOSE = sudo docker-compose -f srcs/docker-compose.yml

.PHONY: all
all:
	mkdir -p $(D_MARIADB)
	mkdir -p $(D_WORDPRESS)
	$(DOCKER_COMPOSE) build
	${MAKE} up

.PHONY: up
up:
	$(DOCKER_COMPOSE) up -d

.PHONY: down
down:
	$(DOCKER_COMPOSE) down -v --rmi all

.PHONY: clean
clean: down
	sudo rm -rf $(D_MARIADB) $(D_WORDPRESS)
	sudo docker system prune -a