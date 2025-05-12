#!/bin/bash

set -e

MOODLE_DIR="/var/www/html"
MOODLE_BRANCH=${MOODLE_BRANCH:-MOODLE_500_STABLE}

echo "Configuring Git safe directory..."
git config --global --add safe.directory $MOODLE_DIR

echo "Pulling latest Moodle updates from branch: $MOODLE_BRANCH"
cd $MOODLE_DIR

# Ensure we are on the correct branch
git fetch --all
git checkout $MOODLE_BRANCH
git pull

echo "Checking for config.php..."
if [ ! -f "${MOODLE_DIR}/config.php" ]; then
  echo "ERROR: config.php is missing. Ensure it is correctly mounted."
  exit 1
fi

echo "Running Moodle upgrade script..."
php admin/cli/upgrade.php --non-interactive || {
  echo "Moodle upgrade failed. Exiting."
  exit 1
}

echo "Starting Apache..."
exec "$@"

