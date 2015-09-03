
#!/bin/sh
# 
## store the arguments given to the script

##  Record the fact that the deploy command has been received
echo "\033[33;32m             Received deploy request at $( date +%F )"


## Switch to right directory
cd /var/www/; \
echo "\033[33;31m             Switched to"
pwd

## GIT RESET
echo "\033[33;31m             GIT reset old code"
git reset --hard

## Start the pull
echo "\033[33;31m             Starting Pull of branch $1 \033[33;32m"
git pull origin "$1"

## After pull, make sure to checkout the branch

echo "\033[33;31m             Starting checkout of branch $1 \033[33;32m"
git checkout "$1"

## Start composer tasks
echo "\033[33;31m             Initiating composer self-update"
composer self-update

echo "\033[33;31m             Initiating composer update"
composer update


echo "\033[33;31m             Initiating composer dump autoload"
composer dump-autoload

## Some cleanup tasks
echo "\033[33;31m             Initiating Artisan clear cache"
php artisan cache:clear

echo "\033[33;31m             Initiating Artisan vendor publish"
php artisan vendor:publish --force


echo "\033[33;31m             Initiating Migration of database"
php artisan migrate

echo "\033[33;35m             All tasks completed succesfully \033[33;32m"
