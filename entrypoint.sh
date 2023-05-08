#! /usr/bin/env bash

set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /app/tmp/pids/server.pid

# bin/rails db:create
RAILS_ENV=production bin/rails db:create
RAILS_ENV=production bin/rails db:migrate

rails server -b 0.0.0.0 -e production
