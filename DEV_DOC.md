# Developer Documentation — Inception

## Prerequisites

Make sure the following are installed on the VM:

```bash
sudo apt update && sudo apt install -y docker.io docker-compose-v2 make git
```

Add your user to the Docker group to avoid using `sudo`:
```bash
sudo usermod -aG docker $USER
```
Then log out and back in.

Add the hostname to `/etc/hosts`:
```bash
echo "127.0.0.1 cwolf.42.fr" | sudo tee -a /etc/hosts
```

---

## Setting Up From Scratch

**1. Clone the repository:**
```bash
git clone <repo-url>
cd inception
```

**2. Create the `.env` file at `srcs/requirements/.env`:**
```env
# MariaDB
SQLDB=<database_name>
SQLUSER=<database_user>
SQLPASS=<database_password>
SQLHOST=mariadb
ROOTPASS=<root_password>

# WordPress
WP_URL=<your_login>.42.fr
WP_TITLE=Inception
WP_ADMIN=<admin_username>
WP_ADMIN_PASS=<admin_password>
WP_ADMIN_EMAIL=<admin_email>
WP_USER=<second_username>
WP_USER_EMAIL=<second_user_email>
WP_USER_PASS=<second_user_password>
```

> The `.env` file must never be committed to the repository. Add it to `.gitignore`.

**3. Create the volume directories:**

These are created automatically by `make`, but can also be created manually:
```bash
mkdir -p /home/$USER/data/mariadb
mkdir -p /home/$USER/data/wordpress
```

---

## Building and Launching

| Command | Description |
|---|---|
| `make` | Build images and start all containers |
| `make build` | Build images only, do not start containers |
| `make up` | Start containers (assumes images are already built) |
| `make down` | Stop and remove containers |
| `make stop` | Stop containers without removing them |
| `make clean` | Remove containers, images, volumes and host data directories |
| `make re` | Full clean rebuild |

---

## Managing Containers

**List running containers:**
```bash
docker compose -f srcs/docker-compose.yml ps
```

**View logs:**
```bash
docker compose -f srcs/docker-compose.yml logs -f
```

**Enter a container shell:**
```bash
# MariaDB
docker exec -it $(docker ps -q --filter name=mariadb) bash

# WordPress
docker exec -it $(docker ps -q --filter name=wordpress) bash

# nginx
docker exec -it $(docker ps -q --filter name=nginx) bash
```

**Connect to the database:**
```bash
docker exec -it $(docker ps -q --filter name=mariadb) mariadb -u root -p
```

**Check WordPress users via WP-CLI:**
```bash
docker exec -it $(docker ps -q --filter name=wordpress) wp user list --allow-root --path=/var/www/html
```

**Full Docker cleanup (removes everything):**
```bash
docker stop $(docker ps -qa)
docker rm $(docker ps -qa)
docker rmi -f $(docker images -qa)
docker volume rm $(docker volume ls -q)
docker network rm $(docker network ls -q) 2>/dev/null
```

---

## Data Storage and Persistence

Data is stored using bind mounts on the host machine:

| Volume | Host Path | Container Path | Contents |
|---|---|---|---|
| `mariadb_data` | `/home/<user>/data/mariadb` | `/var/lib/mysql` | Database files (users, posts, settings) |
| `wordpress_data` | `/home/<user>/data/wordpress` | `/var/www/html` | WordPress PHP files, themes, plugins, uploads |

Since bind mounts are used, data persists on the host even after containers are removed with `make down`. Only `make clean` deletes the host directories and all data.

**Inspect stored data:**
```bash
ls /home/$USER/data/mariadb
ls /home/$USER/data/wordpress
```

---

## Project Structure

```
inception/
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
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