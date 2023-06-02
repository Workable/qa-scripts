function edit_bash(){
 vi ~/.bash_profile
}

#Example:
#curl_withbase64 foo https://workable.jfrog.io/workable/binary-local/base-commander/base-commander-linux-amd64
#  curl -i \
#      -H 'Accept:application/json' \
#      -H 'Authorization:Basic foo' \
#      https://workable.jfrog.io/workable/binary-local/base-commander/base-commander-linux-amd64

function curl_withbase64(){
    curl -i \
        -H 'Accept:application/json' \
        -H "Authorization:Basic $1" \
        $2
}

function find_large_files(){
 du -h -d 1 | grep '[0-9]G\>' | sort -hr
}

function disk_utilization(){
 df -h
}

function kill_chromedrivers(){
 ps -ef | grep chromedriver | grep -v 'grep' |awk {'print $2'} | xargs -I {} kill {}
}

function kill_chromehelpers(){
 ps -ef | grep 'Chrome Helper' |awk {'print $2'} | xargs -I {} kill {}
}

function wait-for-it(){
 ~/.scripts/wait-for-it.sh $1 -- echo "is up"
}

ports='lsof -i -P | grep LISTEN'