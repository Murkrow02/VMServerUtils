#!/bin/bash

# Set the paths and variables
project_name=$1
repo_url=$2
production_folder=$3
temp_folder="/tmp/$project_name"

# Clone the Git repository to a temporary folder
git clone $repo_url $temp_folder

# Navigate to the project folder
cd $temp_folder

# Install Composer dependencies
composer install --no-dev --optimize-autoloader

# Generate the application key
php artisan key:generate --force

# Create a production build
npm install
npm run production

# Publish the project to the production folder
rsync -avz --delete --exclude='.env' $temp_folder/ $production_folder/

# Set appropriate permissions (adjust as needed)
chown -R www-data:www-data $production_folder
chmod -R 755 $production_folder/storage
chmod -R 755 $production_folder/bootstrap/cache

# Cleanup the temporary folder
rm -rf $temp_folder

# Display a success message
echo "Project successfully published to production folder!"
