#!/bin/bash
. $srcdir/diag.sh init
generate_conf
add_conf "\$IncludeConfig ${srcdir}/testsuites/incltest.d/include.conf
"
startup
# 100 messages are enough - the question is if the include is read ;)
. $srcdir/diag.sh injectmsg 0 100
shutdown_when_empty # shut down rsyslogd when done processing messages
wait_shutdown
seq_check 0 99
exit_test
