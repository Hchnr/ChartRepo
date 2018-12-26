#!/usr/bin/env bash

case "$1" in
  file_server)
    exec ./file_server
    ;;
  *)
    # The command is something like bash, not an airflow subcommand. Just run it in the right environment.
    exec "$@"
    ;;
esac
