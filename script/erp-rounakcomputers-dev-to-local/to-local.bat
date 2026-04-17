:: cd C:\odoo\odoo17\script\restore\erp-smartlifefoundation-to-local
:: to-local.bat
cd E:\odoo\odoo-17\script\erp-rounakcomputers-dev-to-local

::take backup from remote both file and database
plink.exe -batch -ssh root@194.163.184.76 -P 1025 -pw 2t8AlUku9dvfhgsu378ehdj839deh -m to-local-remote-script.sh 

::copy files into local
pscp -pw 2t8AlUku9dvfhgsu378ehdj839deh -P 1025 root@194.163.184.76:/root/bk/erp-dev.rounakcomputers.com-bk-1.dump.tar.gz E:\odoo\restore-bk
pscp -pw 2t8AlUku9dvfhgsu378ehdj839deh -P 1025 root@194.163.184.76:/root/bk/erp-dev.rounakcomputers.com-v1.tar.gz E:\odoo\restore-bk

::extract the .dump file
cd E:\odoo\restore-bk
tar -xvzf erp-dev.rounakcomputers.com-bk-1.dump.tar.gz

::down the odoo server
cd E:\odoo\odoo-17
docker-compose -f docker-compose-erp-rounakcomputers.yml down

::copy database restore and delete the existing database
cd E:\odoo\odoo-17\script\erp-rounakcomputers-dev-to-local
docker cp to-local-db-script-pre.sh postgres-db-1:/
docker cp to-local-db-script-post.sh postgres-db-1:/
docker exec -u 0 -it postgres-db-1 chmod +x /to-local-db-script-pre.sh
docker exec -u 0 -it postgres-db-1 chmod +x /to-local-db-script-post.sh
docker exec -u 0 -it postgres-db-1 /to-local-db-script-pre.sh

::restore the database file
docker exec -i postgres-db-1 pg_restore --no-owner -U postgresadmin -v -d "erp-dev.rounakcomputers.com" < "E:\odoo\restore-bk\erp-dev.rounakcomputers.com-bk-1.dump"

:: psql -U odoo -d postgresdb -c 'DROP DATABASE IF EXISTS "erp.smartlifefoundation.org" WITH (FORCE);' -c 'CREATE DATABASE "erp.smartlifefoundation.org";'
:: pg_restore --no-owner -U odoo  -v -d erp.smartlifefoundation.org < "E:\odoo\restore-bk\erp.smartlifefoundation.org-bk-1.dump"

:: psql -U odoo -d postgres -c "DROP DATABASE IF EXISTS \"erp.smartlifefoundation.org\" WITH (FORCE); CREATE DATABASE \"erp.smartlifefoundation.org\";"
:: psql -U odoo -d postgres -c "CREATE DATABASE \"erp.smartlifefoundation.org\";"

docker exec -u 0 -it postgres-db-1 /to-local-db-script-post.sh

::up the odoo server 
cd E:\odoo\odoo-17
docker-compose -f docker-compose-erp-rounakcomputers.yml up -d

cd E:\odoo\odoo-17\script\erp-rounakcomputers-dev-to-local
::copy the filestore to odoo 
docker exec -u 0 -it odoo17-erp-rounakcomputers-1 bash -c "rm /var/lib/odoo/filestore/erp-dev.rounakcomputers.com-v1.tar.gz"
docker cp  E:\odoo\restore-bk\erp-dev.rounakcomputers.com-v1.tar.gz  odoo17-erp-rounakcomputers-1:/var/lib/odoo/filestore
docker cp to-local-fs-script.sh odoo17-erp-rounakcomputers-1:/
docker exec -u 0 -it odoo17-erp-rounakcomputers-1 chmod +x /to-local-fs-script.sh
docker exec -u 0 -it odoo17-erp-rounakcomputers-1 /to-local-fs-script.sh
:: docker exec -u 0  -it postgres-db-1  /bin/bash
:: #$ psql -U postgresadmin -W  -d postgresdb
:: #$ local password : Ftjskiasals3w909sjaosds


