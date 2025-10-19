external_url "https://gitlab.home.local"
letsencrypt['enable'] = false
nginx['redirect_http_to_https'] = true
nginx['redirect_http_to_https_port'] = 8443
nginx['ssl_certificate'] = "/etc/gitlab/ssl/gitlab.home.local.crt"
nginx['ssl_certificate_key'] = "/etc/gitlab/ssl/gitlab.home.local.key"