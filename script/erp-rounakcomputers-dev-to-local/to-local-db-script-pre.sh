#!/bin/bash

PGPASSWORD='Ftjskiasals3w909sjaosds' psql -U postgresadmin -d postgresdb -c 'DROP DATABASE IF EXISTS "erp-dev.rounakcomputers.com" WITH (FORCE);' -c 'CREATE DATABASE "erp-dev.rounakcomputers.com";'
