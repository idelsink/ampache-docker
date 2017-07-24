#!/usr/bin/env sh

# Run the first time setup
# (filling in the parameters that can change)

FIRST_TIME_SETUP_DONE=/var/ampache-docker/first-time-setup

if [ ! -f "${FIRST_TIME_SETUP_DONE}" ]; then
    echo "~~ Running first-time-setup ~~"
    # Run all the scripts from given directory
    run-parts /scripts/first-time-setup/ && \
    mkdir -p "${FIRST_TIME_SETUP_DONE%/*}" && touch "${FIRST_TIME_SETUP_DONE}"
fi
