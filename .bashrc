#!/bin/sh

for file in ~/.rc/*; do
    source "$file"
done
