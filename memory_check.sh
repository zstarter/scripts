#!/bin/bash
#Edwin


usage() { echo "Usage: $0 [-c <value>] [-w <value>]" 1>&2; exit 1; }

MEM=$(free | grep Mem | awk "{print $3/$2 * 100.0}")

while getopts ":c:w:" MEM; do
    case "${MEM}" in
        c)
            c=${OPTARG}
            #((c >= 90)) || usage
            if
                [[ "$c" -ge "90" ]] ; then
                        echo "CRITICAL: Memory usage is above 90%"
#            ((c >= 90)) || echo "C R I T I C A L"
            fi
            ;;
        w)
            w=${OPTARG}
#            ((w >= 60));;
            if
                [[ "$w" -ge "60" ]] ; then
                        echo "WARNING: Memory Usage is above 60%"
            fi
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${c}" ] || [ -z "${w}" ]; then
    usage
fi

#echo "c = ${c}"
#echo "w = ${w}"
