#!bin/sh

timeout=5
while true; do
    tail -f /var/log/apache2/*log
    sleep "${timeout}"
done
