# Portainer Demo

A simple demo showing how to run **Portainer CE**, a lightweight container management UI, using **Podman** on **macOS** with apple silicon.

---

## Run Command

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