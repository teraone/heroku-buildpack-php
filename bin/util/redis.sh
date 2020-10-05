#!/bin/bash
# Build Path: /app/.heroku/php/
dep_url=https://github.com/phpredis/phpredis.git
phpredis_dir=phpredis
echo "-----> Building phpredis..."

echo $PWD

### phpredis
echo "[LOG] Downloading phpredis"
git clone -b 5.3.1 $dep_url -q
if [ ! -d "$phpredis_dir" ]; then
  echo "[ERROR] Failed to find phpredis directory $phpredis_dir"
  exit
fi

cd phpredis
echo $PWD

BUILD_DIR=$1
ln -s $BUILD_DIR/.heroku /app/.heroku
export PATH=/app/.heroku/php/bin:$PATH
phpize
./configure --enable-redis-igbinary --with-php-config=/app/.heroku/php/bin/php-config
make
make install


cd ..
echo "import extension redis into php.ini"
echo "extension=redis.so" >> /app/.heroku/php/etc/php/php.ini
