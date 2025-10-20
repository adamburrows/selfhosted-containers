external_url "https://gitlab.home.local"
letsencrypt['enable'] = false
nginx['ssl_certificate'] = "/etc/gitlab/ssl/fullchain.crt"
nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/gitlab.home.local.key"