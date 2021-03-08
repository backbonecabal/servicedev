#!/bin/bash
# Navigate to your NGINX configuration directory on your server:
cd /etc/nginx
# Create a backup of your current NGINX configuration:
tar -czvf nginx_$(date +'%F_%H-%M-%S').tar.gz nginx.conf sites-available/ sites-enabled/ nginxconfig.io/
# Extract the new compressed configuration archive using tar:
tar -xzvf nginxconfig.io-backbonecabal.xyz.tar.gz
# Create a common ACME-challenge directory (for Let's Encrypt):
mkdir -p /var/www/_letsencrypt
chown nginx /var/www/_letsencrypt
sed -i -r 's/(listen .*443)/\1;#/g; s/(ssl_(certificate|certificate_key|trusted_certificate) )/#;#\1/g' /etc/nginx/sites-available/backbonecabal.xyz.conf
sudo nginx -t && sudo systemctl reload nginx
certbot certonly --webroot -d backbonecabal.xyz -d www.backbonecabal.xyz -d cdn.backbonecabal.xyz --email info@backbonecabal.xyz -w /var/www/_letsencrypt -n --agree-tos --force-renewal
sed -i -r 's/#?;#//g' /etc/nginx/sites-available/backbonecabal.xyz.conf
sudo nginx -t && sudo systemctl reload nginx
echo -e '#!/bin/bash\nnginx -t && systemctl reload nginx' | sudo tee /etc/letsencrypt/renewal-hooks/post/nginx-reload.sh
sudo chmod a+x /etc/letsencrypt/renewal-hooks/post/nginx-reload.sh
sudo nginx -t && sudo systemctl reload nginx