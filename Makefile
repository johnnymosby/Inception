up:
	docker compose -f ./srcs/docker-compose.yml up --build
down:
	docker compose down -f ./srcs/docker-compose.yml