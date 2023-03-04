ARG FRAPPE_VERSION=version-14
ARG FRAPPE_IMAGE_TAG=v14

FROM frappe/bench:latest

ARG FRAPPE_VERSION=version-14
ARG ERPNEXT_VERSION=version-14
ARG FRAPPE_IMAGE_TAG=v14
ARG APP_NAME=librarymanagement

# Setup frappe-bench using FRAPPE_VERSION
RUN bench init --version=${FRAPPE_VERSION} --skip-redis-config-generation --verbose /home/frappe/frappe-bench
WORKDIR /home/frappe/frappe-bench

# Comment following if ERPNext is not required
RUN bench get-app --branch=${ERPNEXT_VERSION} --resolve-deps erpnext

# Copy custom app(s)
COPY --chown=frappe:frappe . apps/${APP_NAME}

# Setup dependencies
RUN bench setup requirements
# Install optional python development dependencies required to generate coverage.
RUN bench setup requirements --dev
RUN pip install pre-commit

# Locate services available in the dev container.
RUN bench set-config -g db_host mariadb
RUN bench set-config -g redis_cache redis://redis-cache:6379
RUN bench set-config -g redis_queue redis://redis-queue:6379
RUN bench set-config -g redis_socketio redis://redis-socketio:6379
