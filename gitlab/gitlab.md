# GitLab Demo

This demo runs a **self-hosted GitLab instance** locally. It supports HTTPS traffic with self-signed SSL certificates or your own trusted CA. I also add a WLAN IP Address to my certificate as a SAN so that my other devices on my home network can access the instance.

---

## Directory Structure

```bash
gitlab/
├── podman-compose.yaml
├── gitlab.rb
├── gitlab-ext.cnf
├── ssl/
    ├── gitlab.home.local.crt 
    ├── gitlab.home.local.key
└── trusted-certs/
    └── rootCA.pem
```

---

## Generate the Root CA and certificate-key pair

### Create a root CA key and certificate

```bash
openssl genrsa -out trusted-certs/rootCA.key 4096

openssl req -x509 -new -nodes -sha256 -days 365 \
-key trusted-certs/rootCA.key \
-out trusted-certs/rootCA.pem \
-subj "/C=US/ST=Local/L=Local/O=LocalDev/CN=Local Root CA"
```

### Create the server key and CSR

```bash
openssl genrsa -out ssl/gitlab.home.local.key 2048

openssl req -new \
-key ssl/gitlab.home.local.key \
-out ssl/gitlab.home.local.csr \
-subj "/C=US/ST=Local/L=Local/O=LocalDev/CN=gitlab.home.local"
```

### Sign the server cert with the root CA

```bash
openssl x509 -req -days 825 -sha256 \
-in ssl/gitlab.home.local.csr \
-CA trusted-certs/rootCA.pem \
-CAkey trusted-certs/rootCA.key \
-CAserial trusted-certs/rootCA.srl \
-out ssl/gitlab.home.local.crt \
-extfile gitlab-ext.cnf
```

### Create the full chain
```bash
cat ssl/gitlab.home.local.crt trusted-certs/rootCA.pem > ssl/fullchain.crt
```

### Verify the chain is valid

```bash
openssl verify -CAfile trusted-certs/rootCA.pem ssl/fullchain.crt
```

---

## Deploy the container

```bash
podman-compose up -d
```

Launch the domain in your browser: e.g. https://gitlab.home.local:8443. You need to create an entry in your local /etc/hosts folder to resolve this domain because it's not resolvable on public DNS.

```bash
vi /etc/hosts
...
192.168.1.192	gitlab.home.local
```

Using the assigned IP will work on another device connected to your WLAN: e.g. https://192.168.1.192:8443.

You can get the initial admin password from the container:

```bash
podman exec -it gitlab grep 'Password:' /etc/gitlab/initial_root_password
```

---

## Demo

coming soon