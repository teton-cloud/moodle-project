#!/bin/bash

set -e

MOODLE_DIR="/var/www/html"
MOODLE_BRANCH=${MOODLE_BRANCH:-MOODLE_500_STABLE}

echo "Pulling latest Moodle updates from branch: $MOODLE_BRANCH"
cd $MOODLE_DIR

# Ensure we are on the correct branch
git fetch --all
git checkout $MOODLE_BRANCH
git pull

echo "Running Moodle upgrade script..."
php admin/cli/upgrade.php --non-interactive

echo "Starting Apache..."
exec "$@"

