#!/bin/bash

set -ex

bench new-site erp.localhost --mariadb-root-password 123 --admin-password 123 --no-mariadb-socket
bench --site erp.localhost set-config developer_mode 1
bench --site erp.localhost clear-cache
bench --site erp.localhost install-app erpnext
bench --site erp.localhost install-app librarymanagement

# Make this the default site.
bench use erp.localhost