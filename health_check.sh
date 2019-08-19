retries_counter=0
max_retries=$1
URL=$2

until [[ "$(curl -o /dev/null -s -w ''%{http_code}'' ${URL})" = "200" ]]; do
    if [ ${retries_counter} -eq ${max_retries} ]
    then
      echo "Max retries reached"
      exit 1
    fi
    printf '.'
    attempt_counter=$(($attempt_counter+1))
    sleep 5
done
