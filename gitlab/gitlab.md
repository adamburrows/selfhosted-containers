# GitLab Demo Deployment

This demo runs a **self-hosted GitLab instance** locally using **Podman or Docker Compose**.  
It supports HTTPS traffic with **self-signed SSL certificates** or your own trusted CA. I also add a WLAN IP Address to my certificate as a SAN so that my other devices on my home network can access the instance.

---

## Directory Structure

Clone this repository and create your own directories for the SSL encryption. Your structure will look like this:

gitlab/
├── podman-compose.yaml
├── gitlab.rb
├── ssl/
    ├── gitlab.home.local.crt
    ├── gitlab.home.local.key
└── trusted-certs/
    └── rootCA.pem

---

## Generate the Root CA and certificate-key pair.

### Create a root CA key and certificate

```bash
openssl genrsa -out rootCA.key 4096

openssl req -x509 -new -nodes -key rootCA.key -sha256 -days 3650 -out rootCA.pem \
  -subj "/C=US/ST=Local/L=Local/O=LocalDev/CN=Local Root CA"
```

### Create the server key and CSR

```bash
openssl genrsa -out gitlab.home.local.key 2048

openssl req -new \
-key gitlab.home.local.key \
-out gitlab.home.local.csr \
-subj "/C=US/ST=Local/L=Local/O=LocalDev/CN=gitlab.home.local"
```

### Create a config for SANs (gitlab-ext.cnf)

```bash
cat > gitlab-ext.cnf <<EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1 = gitlab.home.local
IP.1 = 192.168.1.192
EOF
```

### Sign the server cert with the root CA

```bash
openssl x509 -req -days 825 -sha256 \
-in gitlab.home.local.csr \
-CA rootCA.pem \
-CAkey rootCA.key \
-CAcreateserial \
-out gitlab.home.local.crt \
-extfile gitlab-ext.cnf
```

### Create the full chain
```bash
cat gitlab.home.local.crt rootCA.pem > fullchain.crt
```

### Verify the chain is valid

```bash
openssl verify -CAfile rootCA.pem fullchain.crt
```

---

## Run the container

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