server {
    listen 443 ssl ;
    http2 on;
    server_name qbt.archfan.com;

    gzip on;
    gzip_vary on;
    gzip_proxied any;
    gzip_comp_level 6;
    gzip_types text/plain text/css text/xml application/json application/javascript application/xml+rss application/atom+xml image/svg+xml;

    client_body_buffer_size 10K;
    client_header_buffer_size 1k;
    client_max_body_size 8m;
    large_client_header_buffers 2 1k;

    error_page 404 /404.html;

    #location ~* \.(jpg|jpeg|png|gif|ico|css|js|webp)$ {
    #    expires 30d;
    #    add_header Cache-Control "public, no-transform";
    #}

    location / {
        proxy_pass http://qbittorrent:80;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }

}


