#!/bin/sh

is_login_shell() {
    shopt | grep login_shell | grep -q on 
}


for file in ~/.rc/*; do
    source "$file"
done
