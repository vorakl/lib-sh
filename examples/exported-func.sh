#!/bin/bash

start() {
    source <(curl -sSLf http://bash.libs.cf/latest/sys)
    source <(curl -sSLf http://bash.libs.cf/latest/str)

    str_say "The function 'str_say' is exported"
    bash -c 'str_say hello'
    str_say "The function 'str_err' is NOT exported"
    bash -c 'str_err world'
}

__str_init__() {
    __str_exported="str_say"
}

start
