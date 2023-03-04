#!/bin/bash

set -ex

# Create site.
bench new-site erp.localhost --mariadb-root-password 123 --admin-password 123 --no-mariadb-socket --force
bench --site erp.localhost set-config developer_mode 1
bench --site erp.localhost clear-cache
bench --site erp.localhost install-app erpnext
bench --site erp.localhost install-app librarymanagement

# Make this the default site.
bench use erp.localhost

# Complete setup wizard.
echo "Complete setup wizard..."

export SETUP_COMPANY_ABBR="LM"
export SETUP_COMPANY_NAME="Library Management"
export SETUP_TIMEZONE="America/Los_Angeles"

# Pass $SETUP_COMPANY_ABBR as `company_name` to set the Company ID to $SETUP_COMPANY_ABBR.
bench --site erp.localhost execute frappe.desk.page.setup_wizard.setup_wizard.setup_complete  --args='["""{
 "currency": "USD",
 "full_name": "Library Management",
 "company_name": "'"$SETUP_COMPANY_ABBR"'",
 "timezone": "'"$SETUP_TIMEZONE"'",
 "company_abbr": "'"$SETUP_COMPANY_ABBR"'",
 "country": "United States",
 "fy_start_date": "2023-01-01",
 "fy_end_date": "2023-12-31",
 "language": "English (United States)",
 "company_tagline": "Library Management",
 "email": "support@librarymanagement.com",
 "password": "123",
 "chart_of_accounts": "Standard"
}"""]'
bench --site erp.localhost execute frappe.client.set_value --args='["Company", "'"$SETUP_COMPANY_ABBR"'", "company_name", "'"$SETUP_COMPANY_NAME"'"]'
