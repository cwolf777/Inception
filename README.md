*This project has been created as part of the 42 curriculum by cwolf.*

---

# Inception

## Description

Inception is a system administration project from the 42 curriculum. The goal is to set up a small but complete web infrastructure using Docker and Docker Compose, running entirely inside a virtual machine.

The infrastructure consists of three services, each running in its own Docker container:

- **MariaDB** – the relational database that stores all WordPress data
- **WordPress + PHP-FPM** – the web application and content management system
- **nginx** – the reverse proxy that handles all incoming HTTPS traffic and forwards PHP requests to WordPress

All containers communicate through a custom Docker bridge network called `inception_network`. Data is persisted using bind-mount volumes on the host machine.

## Instructions

### Requirements

- Docker and Docker Compose installed
- `make` installed (`sudo apt install make`)
- The hostname `<login>.42.fr` must be added to `/etc/hosts`:

```bash
echo "127.0.0.1 cwolf.42.fr" | sudo tee -a /etc/hosts
```

### Setup

1. Clone the repository:

```bash
git clone <repo-url>
cd inception
```

2. Create the `.env` file at `srcs/requirements/.env`:

```env
# MariaDB
SQLDB=
SQLUSER=
SQLPASS=
SQLHOST=
ROOTPASS=

# WordPress
WP_URL=user.42.fr
WP_TITLE=
WP_ADMIN=
WP_ADMIN_PASS=
WP_ADMIN_EMAIL=
WP_USER=
WP_USER_EMAIL=
WP_USER_PASS=
```

3. Start the infrastructure:

```bash
make
```

The site will be available at `https://cwolf.42.fr`.

### Makefile Commands

| Command | Description |
|---|---|
| `make` / `make all` | Creates volume directories and starts all containers |
| `make build` | Builds all Docker images without starting containers |
| `make down` | Stops and removes containers |
| `make stop` | Stops containers without removing them |
| `make clean` | Removes containers, images, volumes and all data |
| `make re` | Full rebuild from scratch |

---

## Project Structure

```
inception/
├── Makefile
├── README.md
└── srcs/
    ├── docker-compose.yml
    └── requirements/
        ├── .env
        ├── mariadb/
        │   ├── Dockerfile
        │   ├── conf/my.cnf
        │   └── tools/setup.sh
        ├── wordpress/
        │   ├── Dockerfile
        │   ├── conf/www.conf
        │   └── tools/setup.sh
        └── nginx/
            ├── Dockerfile
            ├── conf/nginx.conf
            └── tools/setup.sh
```

---

## Resources

### Documentation

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Reference](https://docs.docker.com/compose/)
- [nginx Documentation](https://nginx.org/en/docs/)
- [MariaDB Documentation](https://mariadb.com/kb/en/)
- [WordPress CLI (WP-CLI)](https://wp-cli.org/)
- [PHP-FPM Configuration](https://www.php.net/manual/en/install.fpm.configuration.php)
- [OpenSSL Documentation](https://www.openssl.org/docs/)
- [TLS 1.3 RFC 8446](https://datatracker.ietf.org/doc/html/rfc8446)

### AI Usage

Claude (Anthropic) was used throughout this project for the following tasks:

- Understanding concepts: Docker networking, volumes, bind mounts, TLS/SSL certificates, PHP-FPM configuration, nginx reverse proxy setup, MariaDB initialization, and general debugging of container communication issues.

- Configuration — nginx, MariaDB, and PHP-FPM configuration files were written and reviewed with AI assistance.

- Code review — entrypoint scripts and Dockerfiles were reviewed for correctness and best practices.

- Generating this README