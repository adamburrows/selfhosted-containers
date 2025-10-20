# Keycloak Demo

This repository demonstrates running **Keycloak** with a **PostgreSQL backend**.

---

## Features

- Keycloak 23.x with development mode enabled
- PostgreSQL 15 as the database
- Metrics and health checks enabled
- Admin user preconfigured (`admin/admin`)
- Easy to start and stop using Podman Compose or Docker Compose
- Persistent database using named volumes

## Run the container

```bash
podman-compose up -d
```

Open http://localhost:8080 in your web browser and login wth user:pass = admin:admin.