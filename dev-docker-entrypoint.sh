#!/bin/bash
set -e

# Check Environment
echo  "Environment: $RAILS_ENV"

# Check Bundle
echo "Bundle check..."
bundle check || bundle install

# Remove Existing Server pid
echo "Remove pre-existing server.pid..."
rm -f /app/tmp/pids/server.pid

echo "Cleaning temp files..."
rm -rf tmp/*

bundle exec rake db:migrate 2>/dev/null || bundle exec rake db:setup

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"