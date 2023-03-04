#!/bin/bash

set -ex

PROJECT_DIR=~/frappe-bench/apps/librarymanagement

cd $PROJECT_DIR

bench new-site erp.localhost
bench --site erp.localhost set-config developer_mode 1
bench --site erp.localhost clear-cache
bench --site erp.localhost install-app erpnext

# Make this the default site.
bench use erp.localhost