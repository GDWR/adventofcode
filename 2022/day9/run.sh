#!/usr/bin/env bash

fpc main.pas || exit
printf "\n\n"
./main
