#!/bin/sh
#

# Starting node npm
if [ -f "/usr/local/bin/npm" ]; then
  echo "+++ Starting now /usr/local/bin/npm with node server.js..."
  
  cd /usr/src/app/
  
  #exec su-exec logstash ${LOGSTASH_HOME}/bin/logstash
  exec /usr/local/bin/npm
fi
#
#END
