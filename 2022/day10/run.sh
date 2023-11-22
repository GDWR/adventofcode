#!/usr/bin/env bash

# Compile source
ghc -dynamic Main.hs || exit


cat data | ./Main

