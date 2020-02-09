# setup PowerDNS

if mdata-get pdns_mysql_host2 1>/dev/null 2>&1; then
  MDATA_VALUE=`mdata-get pdns_mysql_host2`
  
  sed -i "s|# launch=gmysql:db1,gmysql:db2|launch=gmysql:db1,gmysql:db2|" /opt/local/etc/pdns.conf
  sed -i "s|# gmysql-db1-dnssec|gmysql-db1-dnssec|" /opt/local/etc/pdns.conf
  sed -i "s|# gmysql-db2-dnssec|gmysql-db2-dnssec|" /opt/local/etc/pdns.conf
  sed -i "s|# gmysql-db1-port=3306|gmysql-db1-port=3306|" /opt/local/etc/pdns.conf
  sed -i "s|# gmysql-db2-port=3306|gmysql-db2-port=3306|" /opt/local/etc/pdns.conf
  sed -i "s|# gmysql-db2-host=|gmysql-db2-host=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
  
  if mdata-get pdns_mysql_host 1>/dev/null 2>&1; then
    MDATA_VALUE=`mdata-get pdns_mysql_host`
    sed -i "s|# gmysql-db1-host=|gmysql-db1-host=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
  fi
  
  if mdata-get pdns_mysql_db 1>/dev/null 2>&1; then
    MDATA_VALUE=`mdata-get pdns_mysql_db`
    sed -i "s|# gmysql-db1-dbname=|gmysql-db1-dbname=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
    sed -i "s|# gmysql-db2-dbname=|gmysql-db2-dbname=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
  fi

  if mdata-get pdns_mysql_user 1>/dev/null 2>&1; then
    MDATA_VALUE=`mdata-get pdns_mysql_user`
    sed -i "s|# gmysql-db1-user=|gmysql-db1-user=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
    sed -i "s|# gmysql-db2-user=|gmysql-db2-user=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
  fi

  if mdata-get pdns_mysql_pwd 1>/dev/null 2>&1; then
    MDATA_VALUE=`mdata-get pdns_mysql_pwd`
    sed -i "s|# gmysql-db1-password=|gmysql-db1-password=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
    sed -i "s|# gmysql-db2-password=|gmysql-db2-password=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
  fi

else
  sed -i "s|# launch=gmysql;|launch=gmysql|" /opt/local/etc/pdns.conf
  sed -i "s|# gmysql-dnssec|gmysql-dnssec|" /opt/local/etc/pdns.conf
  sed -i "s|# gmysql-port=3306|gmysql-port=3306|" /opt/local/etc/pdns.conf
  
  if mdata-get pdns_mysql_host 1>/dev/null 2>&1; then
    MDATA_VALUE=`mdata-get pdns_mysql_host`
    sed -i "s|# gmysql-host=|gmysql-host=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
  fi

  if mdata-get pdns_mysql_db 1>/dev/null 2>&1; then
    MDATA_VALUE=`mdata-get pdns_mysql_db`
    sed -i "s|# gmysql-dbname=|gmysql-dbname=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
  fi

  if mdata-get pdns_mysql_user 1>/dev/null 2>&1; then
    MDATA_VALUE=`mdata-get pdns_mysql_user`
    sed -i "s|# gmysql-user=|gmysql-user=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
  fi

  if mdata-get pdns_mysql_pwd 1>/dev/null 2>&1; then
    MDATA_VALUE=`mdata-get pdns_mysql_pwd`
    sed -i "s|# gmysql-password=|gmysql-password=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
  fi
  
fi

if mdata-get allow_axfr_ips 1>/dev/null 2>&1; then
  MDATA_VALUE=`mdata-get allow_axfr_ips`
  sed -i "s|# allow-axfr-ips=127.0.0.0/8,::1|allow-axfr-ips=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
fi

if mdata-get pdns_api_enable 1>/dev/null 2>&1; then
  MDATA_VALUE=`mdata-get pdns_api_enable`
  sed -i "s|# api=no|api=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
fi

if mdata-get pdns_api_key 1>/dev/null 2>&1; then
  MDATA_VALUE=`mdata-get pdns_api_key`
  sed -i "s|# api-key=|api-key=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
fi

if mdata-get pdns_local_port 1>/dev/null 2>&1; then
  MDATA_VALUE=`mdata-get pdns_local_port`
  sed -i "s|local-port=53|local-port=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
fi

if mdata-get pdns_master 1>/dev/null 2>&1; then
  MDATA_VALUE=`mdata-get pdns_master`
  sed -i "s|# master=no|master=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
fi

if mdata-get pdns_slave 1>/dev/null 2>&1; then
  MDATA_VALUE=`mdata-get pdns_slave`
  sed -i "s|# slave=no|slave=${MDATA_VALUE}|" /opt/local/etc/pdns.conf
fi

HOSTNAME=$(hostname -s)
sed -i "s|server-id=none|server-id=${HOSTNAME}|" /opt/local/etc/pdns.conf

svcadm enable svc:/pkgsrc/pdns:default
