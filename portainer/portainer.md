# Portainer Demo

A simple demo showing how to run **Portainer CE** on macOS with apple silicon.

**Portainer** is a lightweight, open-source management tool that provides a user-friendly web interface for deploying, managing, and monitoring containerized applications across Docker, Podman, and Kubernetes environments. 

---

## Deploy the container

```bash
podman run -d \
-p 8000:8000 \
-p 9443:9443 \
--name portainer \
--restart=always \
--privileged \
-v /run/podman/podman.sock:/var/run/docker.sock \
-v portainer_data:/data \
portainer/portainer-ce:lts
```

Launch the UI from https://localhost:9443.

---

## Demo

coming soon