#!/bin/bash

## hyphop ##

#= system monitor cpu mem

#QUERY_STRING=c time ./stats.cgi
#QUERY_STRING=c% time ./stats.cgi
#QUERY_STRING=ccpu_% time ./stats.cgi

#QUERY_STRING=m time ./stats.cgi
#QUERY_STRING=m% time ./stats.cgi
#QUERY_STRING=mmem_% time ./stats.cgi

#P=${SCRIPT_FILENAME%/*}

cat << EOF
Date: Thu, 01 Jan 1970 01:47:13 GMT
Cache-Control: no-cache,no-store,max-age=0,must-revalidate
Content-type: text/plain
Pragma: no-cache
Expires: 0
Connection: close
X-SCRIPT_FILENAME: $SCRIPT_FILENAME
X-QUERY_STRING: $QUERY_STRING

EOF

S=${QUERY_STRING:0:1}
s=${QUERY_STRING#$S}
p=$s
s=${s%\%}
[ "$s" = "$p" ] || P="%"

case "$QUERY_STRING" in
	# ccpu_%
	c*)
#	printf "%x" $((RANDOM/255))
#https://supportcenter.checkpoint.com/supportcenter/portal?eventSubmit_doGoviewsolutiondetails=&solutionid=sk65143
(
read l
for c in $l; do
    echo $c
done | (

[ -f /tmp/cpu.usage ] && \
. /tmp/cpu.usage

read c
read user
read nice
read system
read idle
read io
read irq
read soft

echo "user1=$user
nice1=$nice
system1=$system
idle1=$idle
io1=$io
irq1=$irq
soft1=$soft
" > /tmp/cpu.usage

i=$(((($idle-$idle1)*100)/($user-$user1+$nice-$nice1+$system-$system1+$idle-$idle1+$io-$io1+$irq-$irq1+$soft-$soft1)))

echo "$s$((100-$i))$P"
exit 0
)
) < /proc/stat

	;;
	c)
#	for cat /proc/stat | head -1
	echo "xx"
	;;
	t)
	echo "tt"
	;;
	m*)
	egrep -m2 -o -w  "[0-9]+" /proc/meminfo | (
	read l
	read k
#	echo "$s$((k*100/$l))$P"
	echo "$s$((100-k*100/$l))$P"
	)
	;;
	*)
	echo "$QUERY_STRING"
	;;
esac

