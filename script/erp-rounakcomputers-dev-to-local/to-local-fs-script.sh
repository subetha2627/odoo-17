#!/bin/bash

cd /var/lib/odoo/filestore
rm -rf erp-dev.rounakcomputers.com
cd /
tar -zxvf /var/lib/odoo/filestore/erp-dev.rounakcomputers.com-v1.tar.gz  
chown -R odoo:odoo /var/lib/odoo/filestore