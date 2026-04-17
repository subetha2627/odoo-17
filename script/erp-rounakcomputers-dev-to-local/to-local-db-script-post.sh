#!/bin/bash

PGPASSWORD='Ftjskiasals3w909sjaosds' psql -U postgresadmin -d 'erp-dev.rounakcomputers.com' -c "update ir_config_parameter set value='http://localhost:8193' where key='report.url' ;update ir_config_parameter set value='http://localhost:8193' where key='web.base.url'"
PGPASSWORD='Ftjskiasals3w909sjaosds' psql -U postgresadmin -d 'erp-dev.rounakcomputers.com' -c "update res_users set password='\$pbkdf2-sha512\$25000\$XyuFUEqJce6dc06pdS7lXA\$DIX3hpuOpYRSoRwXkixWLpHrHmgIRRkGAMAF7D9tCznFAA52oT0Pi2mbN6O0NwpT1h.MOvuCRIFccJu2NzxcIg' where login='admin@adigielite.com'"
#P4BusWSNB7StMw88N

