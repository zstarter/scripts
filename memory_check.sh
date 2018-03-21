#!/bin/bash
#Edwin


usage()

{
        if [ "$#" -ne 2 ]; then
                echo "Usage: $0 [-c <value>] [-w <value>] [-e recipient]" 1>&2; exit 1;
        fi
}

MEM=$(free | grep Mem | awk '{print $3/$2*100.0}')
PID=$(ps eo pid,%mem --sort=-%mem | head)
DATE=$(date '+%Y-%m-%d %H:%M:%S')


while getopts ":c:w:e" MEM; do
    case "${MEM}" in
        c)
            c=${OPTARG}
            ;;
        w)
            w=${OPTARG}
            ;;
        e)
            e=${OPTARG}
            ;;

        *)
            usage
            ;;
    esac
done

shift $((OPTIND-1))

        if [[ "${w}" -ge "60" && "$w" -lt "90" ]] ; then

                echo "WARNING: Memory Usage is above 60%"
        else
                usage
				fi

        if [[ "$c" -ge "90" && "$w" -ge "60" ]] ; then

                echo "CRITICAL: Memory usage is above 90%"
                echo "Subject: $DATE memory check - critical" > /tmp/email
                echo "$PID" >> /tmp/email
                /usr/sbin/sendmail "$e" < /tmp/email
                rm -f /tmp/email
        else

                usage

        fi