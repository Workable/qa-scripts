export JENKINS_TOKEN=X

function trigger_qa_tests_remotely(){
 BRANCH=$1
 TIMES=$2
 INTERVAL=$3
 COMMAND="curl --user manos@workable.com:$JENKINS_TOKEN -X POST https://jenkins.internal.workableops.net/jenkins/job/qa-tests/job/$BRANCH/buildWithParameters?FILL_NFS_CACHE=false"
 for i in {1..100};do curl --user manos@workable.com:$JENKINS_TOKEN -X POST https://jenkins.internal.workableops.net/jenkins/job/qa-tests/job/increase_timeouts/buildWithParameters?FILL_NFS_CACHE=false;sleep 5; done
}