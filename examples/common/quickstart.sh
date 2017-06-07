#!/bin/bash

main() {
    # bootstrap the common library each time in run-time without saving on a disk
    source <(
        exec 3<>/dev/tcp/lib-sh.vorakl.name/80
        printf "GET http://lib-sh.vorakl.name/common HTTP/1.1\nHost: lib-sh.vorakl.name\nConnection: close\n\n" >&3
        body=0; 
        while IFS= read -u 3 -r str; do 
            if (( body )); then 
                printf "%s\n" "${str}"
            else 
                [[ -z "${str%$'\r'}" ]] && body=1
            fi
        done
        exec 3>&-
    )

    local _out="" _err=""

    say "usage: $0 command arg ..."
    say "I'm about to run '$*'"
    run --warn --save-out _out --save-err _err "$@"

    say "StdOut:"
    say "${_out}"

    say "StdErr:"
    say "${_err}"
}

main "$@"
