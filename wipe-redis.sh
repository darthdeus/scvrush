#!/bin/sh

keys=`redis-cli keys '*' | sed "s/[0-9]*\(.*\)\n/'\1'/g"`

arr=$(echo $keys)

for key in $keys
do
  echo "DEL $key" && redis-cli DEL $key
done