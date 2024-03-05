#!/bin/bash

# Set the default argument
arg=${1:-testing/goo}

docker-compose run compilation "/bin/bash" "-c" "ROSETTA_DEBUGSERVER_PORT=1234 $arg & gdb -q -iex \"set auto-load safe-path /home/opam/project/\" -ex \"set architecture i386:x86-64\" -ex \"file $arg\" -ex \"target remote localhost:1234\""