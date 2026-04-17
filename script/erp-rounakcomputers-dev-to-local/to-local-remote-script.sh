#!/bin/bash

# Set backup directory
cd /root/bk || exit

# Get Docker container names and Define database name
docker_db_name=$(docker ps --format "{{.Names}}" | grep '^rounakcomputerserp-db-6u5pcr')
docker_app_name=$(docker ps --format "{{.Names}}" | grep '^rounakcomputerserp-app-88g9sn')
db_name="erp-dev.rounakcomputers.com"

# Validate that containers exist
if [[ -z "$docker_db_name" || -z "$docker_app_name" ]]; then
    echo "Error: One or both Docker containers not found."
    exit 1
fi

# Remove old database dump
sudo rm -f "${db_name}-bk-1.dump"
sudo rm -f "${db_name}-bk-1.dump.tar.gz"

# Dump PostgreSQL database
docker exec "$docker_db_name" bash -c "pg_dump -U dbadmin -F t \"$db_name\"" > "${db_name}-bk-1.dump"

# Compress the database dump
sudo tar -zcvf "${db_name}-bk-1.dump.tar.gz" "${db_name}-bk-1.dump"

# Archive the Odoo filestore
sudo docker exec -u 0 -i "$docker_app_name" bash -c "rm -f /${db_name}-v1.tar.gz"
sudo docker exec -u 0 -i "$docker_app_name" bash -c "tar -zcvf /${db_name}-v1.tar.gz /var/lib/odoo/filestore/${db_name}"

# Copy the archive from the container to the host
sudo docker cp "$docker_app_name:/${db_name}-v1.tar.gz" /root/bk

# Success message
echo "Backup completed successfully!"