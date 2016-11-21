#!bin/sh

timeout=5
file=/var/log/apache2/*log
while true; do
    tail -f ${file}
    sleep "${timeout}"
done
