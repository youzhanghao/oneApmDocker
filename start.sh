#!/usr/bin/env bash

# set -ex
# Edit by reworld replace by defined config

# load user defined config
configFile="/opt/config/oneapm.properties";
if [  -f "$configFile" ];then
    echo "Load user defined oneapm.properties"
    \cp /opt/config/*oneapm.properties /opt/OneAPM/oneapm.properties
fi
configFile="/opt/config/collector.properties";
if [  -f "$configFile" ];then
    echo "Load user defined collector.properties"
    \cp /opt/config/*collector.properties /opt/OneAPM/collector/collector.properties
fi
# for collector alive
alive(){
while true
do
	echo "health...."
	sleep 1h
done
}
stand_tmp=$(echo   $STAND_ALONE   |   tr   [a-z]   [A-Z]) 
flag=$(echo "yes"   |   tr   [a-z]   [A-Z]) 
if [ "$stand_tmp" = "$flag" ]; then
	echo "---- start collector... ----"
    alive
fi
echo "java app should be run.... Please ensure that jar in /opt/ "
oneapme_agent_tmp=$(echo   $ONEAPM_AGENT   |   tr   [a-z]   [A-Z])
if [ "$oneapme_agent_tmp" = "$flag" ]; then
	# load defined app
	appName=`echo $APP_NAME`;
	tierName=`echo $TIER_NAME`;
	oneApmKey=`echo $ONEAPM_KEY`;
	if [[ ! -n "$appName" ]] || [[ ! -n "$tierName" ]] || [[ ! -n "$oneApmKey" ]]; then
		echo "Waring: you should point out key , appName , tierName "
		exit 1
	fi
	echo "Now app_name is $appName,tier_name is $tierName"
	sed -i "s|app_name = .*$|app_name = $appName|" /opt/OneAPM/oneapm.properties 
	sed -i "s|tier_name = .*$|tier_name = $tierName|" /opt/OneAPM/oneapm.properties
	sed -i "s|license_key = .*$|license_key = $oneApmKey|" /opt/OneAPM/oneapm.properties
	echo "--- start app with agent ----"
	java -Dfile.encoding=utf-8  -jar -Duser.timezone="Asia/Shanghai"  -javaagent:/opt/OneAPM/oneapm.jar $JAVA_OPTS /opt/*.jar
else
	echo "--- start app ---"
	java -Dfile.encoding=utf-8  -jar -Duser.timezone="Asia/Shanghai"  $JAVA_OPTS /opt/*.jar
fi
