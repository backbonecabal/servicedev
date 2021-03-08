ps -lfC nginx | awk '/nginx:/ && /www-data/{count++} END{print count}'
