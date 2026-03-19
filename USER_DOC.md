# User Documentation — Inception

## What Services Are Provided?

This stack runs a complete WordPress website with the following services:

| Service | Description |
|---|---|
| **WordPress** | The website and content management system |
| **MariaDB** | The database that stores all website content |
| **nginx** | The web server that handles incoming traffic over HTTPS |

The website is accessible at `https://cwolf.42.fr`.

---

## Starting and Stopping the Project

**Start the project:**
```bash
make
```

**Stop the project (keeps data):**
```bash
make down
```

**Stop without removing containers:**
```bash
make stop
```

**Full reset (deletes all data):**
```bash
make clean
```

---

## Accessing the Website

**Public website:**
```
https://cwolf.42.fr
```

> Your browser may show a security warning because the SSL certificate is self-signed. Click "Advanced" and proceed anyway.

**WordPress Administration Panel:**
```
https://cwolf.42.fr/wp-admin
```

---

## Credentials

All credentials are stored in the `.env` file located at:
```
srcs/requirements/.env
```

| What | Where to find |
|---|---|
| WordPress Admin | `WP_ADMIN` / `WP_ADMIN_PASS` in `.env` |
| WordPress User | `WP_USER` / `WP_USER_PASS` in `.env` |
| Database User | `SQLUSER` / `SQLPASS` in `.env` |
| Database Root | `ROOTPASS` in `.env` |

> The `.env` file is not included in the repository. Ask the administrator for the credentials.

---

## Checking That Services Are Running

**Check container status:**
```bash
docker compose -f srcs/docker-compose.yml ps
```

All three containers (`mariadb`, `wordpress`, `nginx`) should show as `running` or `healthy`.

**Check logs:**
```bash
docker compose -f srcs/docker-compose.yml logs
```

**Check a specific service:**
```bash
docker compose -f srcs/docker-compose.yml logs wordpress
docker compose -f srcs/docker-compose.yml logs mariadb
docker compose -f srcs/docker-compose.yml logs nginx
```

**Test HTTPS is working:**
```bash
curl -k https://cwolf.42.fr
```

**Test HTTP is blocked (should fail):**
```bash
curl http://cwolf.42.fr
```