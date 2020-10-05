#!/bin/bash
# Build Path: /app/.heroku/php/
dep_url=git://github.com:igbinary/igbinary.git
igbinary_dir=cphalcon
echo "-----> Building Igbinary..."

### Igbinary
echo "[LOG] Downloading igbinary"
git clone -b 3.1.5 $dep_url -q
if [ ! -d "$igbinary_dir" ]; then
  echo "[ERROR] Failed to find igbinary directory $igbinary_dir"
  exit
fi
cd $igbinary_dir/build

BUILD_DIR=$1
ln -s $BUILD_DIR/.heroku /app/.heroku
export PATH=/app/.heroku/php/bin:$PATH
/app/php/bin/phpize
./configure --enable-igbinary --with-php-config=$PHP_ROOT/bin/php-config
make
make install

cd
echo "import extension igbinary into php.ini"
echo "extension=igbinary.so" >> /app/.heroku/php/etc/php/php.ini
