function edit_bash(){
 vi ~/.bash_profile
}

function find_large_files(){
 du -h -d 1 / 2>/dev/null | grep '[0-9]G\>' | sort -hr
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