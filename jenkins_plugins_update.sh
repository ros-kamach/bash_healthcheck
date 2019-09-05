#!/bin/bash
LOGIN=$1
PASS=$2
URL="http://127.0.0.1:8080/login"
while [ 1 ]; do
http_response=$(curl -o /dev/null -s -w ''%{http_code}'' ${URL})
    if [ $http_response = "200" ]
    then
       break
    else
       echo "Waiting for 200"
    fi
sleep 10
done

UPDATE_LIST=$( java -jar /var/lib/jenkins/war/WEB-INF/jenkins-cli.jar -s http://127.0.0.1:8080/ -auth ${LOGIN}:${PASS} list-plugins | grep -e ')$' | awk '{ print $1 }' );
        if [ ! -z "${UPDATE_LIST}" ]
            then
            echo Updating Jenkins Plugins: ${UPDATE_LIST};
            java -jar /var/lib/jenkins/war/WEB-INF/jenkins-cli.jar -s http://127.0.0.1:8080/ -auth ${LOGIN}:${PASS} install-plugin ${UPDATE_LIST};
            java -jar /var/lib/jenkins/war/WEB-INF/jenkins-cli.jar -s http://127.0.0.1:8080 -auth ${LOGIN}:${PASS} safe-restart;
        fi
