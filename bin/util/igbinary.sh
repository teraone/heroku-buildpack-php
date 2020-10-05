#!/bin/bash
# Build Path: /app/.heroku/php/
dep_url=https://github.com/igbinary/igbinary.git
igbinary_dir=igbinary
echo "-----> Building Igbinary..."

echo $PWD

### Igbinary
echo "[LOG] Downloading igbinary"
git clone -b 3.1.5 $dep_url -q
if [ ! -d "$igbinary_dir" ]; then
  echo "[ERROR] Failed to find igbinary directory $igbinary_dir"
  exit
fi

cd igbinary
echo $PWD

BUILD_DIR=$1
ln -s $BUILD_DIR/.heroku /app/.heroku
export PATH=/app/.heroku/php/bin:$PATH
phpize
./configure --enable-igbinary --with-php-config=/app/.heroku/php/bin/php-config
make
make install

cd
echo "import extension igbinary into php.ini"
echo "extension=igbinary.so" >> /app/.heroku/php/etc/php/php.ini
