#!/bin/sh
RED_LED="24"
GREEN_LED="23"
GPIO="/sys/class/gpio"

start() {
	echo -"Starting Tally"
	echo $GREEN_LED > "$GPIO"/export 2>/dev/null
	echo $RED_LED > "$GPIO"/export 2>/dev/null
	sleep 1
	echo out > "$GPIO"/gpio"$GREEN_LED"/direction
	echo out > "$GPIO"/gpio"$RED_LED"/direction
	echo 1 > "$GPIO"/gpio"$GREEN_LED"/value
	while true
	do
		echo -e "\033[9;0]"
		echo 0 > "$GPIO"/gpio"$RED_LED"/value
		/root/tally --discovery-interface=eth0
		echo "CRASHED!"
		echo 1 > "$GPIO"/gpio"$RED_LED"/value
		echo 6 > "$GPIO"/unexport 2>/dev/null
		echo 13 > "$GPIO"/unexport 2>/dev/null
		echo 19 > "$GPIO"/unexport 2>/dev/null
		echo 26 > "$GPIO"/unexport 2>/dev/null
		echo 12 > "$GPIO"/unexport 2>/dev/null
		echo 16 > "$GPIO"/unexport 2>/dev/null
		echo 20 > "$GPIO"/unexport 2>/dev/null
		echo 21 > "$GPIO"/unexport 2>/dev/null
		sleep 2
	done

}

stop() {
	true
}

restart() {
	stop
	start
}

case "$1" in
	start)
		start
		;;
	stop)
		stop
	;;
	restart|reload)
		restart
		;;
	*)
		echo "Usage: $0 {start|stop|restart}"
		exit 1
esac

exit $?
