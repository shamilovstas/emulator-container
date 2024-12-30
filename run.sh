#!/bin/sh

adb kill-server && adb -a start-server
exec "$@"
