# Creates a webhook for a contract in the pact broker
#
# example: pact_create_webhook "AtsApi" "OnDemand"
#
export BROKER_BASE_URL=https://pact-broker.internal.workableops.net
export PACT_BROKER_AUTH_USR=jenkins
export PACT_BROKER_AUTH_PSW=X
export JENKINS_TRIGGER_TOKEN=X
function pact_create_webhook() {
 curl  -l -v --user ${PACT_BROKER_USERNAME}:${PACT_BROKER_PASSWORD} --header "Content-Type: application/json" \
    --request POST \
    --data "{
      \"provider\": {
        \"name\": \"$1\"
      },
      \"consumer\": {
        \"name\": \"$2\"
      },
      \"events\": [
        {
          \"name\": \"contract_content_changed\"
        }
      ],
      \"request\": {
        \"method\": \"POST\",
        \"url\": \"https://jenkins.internal.workableops.net/jenkins/job/Workable%20ATS%20Continuous%20Integration/job/master/buildWithParameters?CONTRACT_TESTS_ONLY=true\&PACT_CONSUMER_NAME=\${pactbroker.consumerName}\&PACT_CONSUMER_VERSION_TAG=\${pactbroker.consumerVersionTags}\&PACT_CONTRACT_LINK=\${pactbroker.pactUrl}\",
        \"headers\": {
          \"Content-Type\": \"application/json\",
          \"Authorization\": \"Basic X=\"
        },
        \"body\": {
        }
      }
    }
    " \
    $BROKER_BASE_URL/webhooks/provider/$1/consumer/$2
}



function k_port_forward_broker(){
  term=pactbroker-web
  pod_name=`kubectl get -A pods | grep $term | awk {'print $2'}`
  kubectl -n pact port-forward $pod_name 8080:9292
}

function k_port_forward_broker_db(){
  term=pact-broker-db
  pod_name=`kubectl get -A pods | grep $term | awk {'print $2'}`
  kubectl -n pact port-forward $pod_name 5433:5432
}

function k_port_forward_stub(){
 term=pact-stub-server
 pod_name=`kubectl get -A pods | grep $term | awk {'print $2'}`
 kubectl -n pact port-forward $pod_name 8080:8080
}

function ats_provider_verifier(){
 pact-provider-verifier --pact-broker-base-url=${PACT_BROKER_URL} --broker-username=${PACT_BROKER_USERNAME} --broker-password=${PACT_BROKER_PASSWORD} --provider=AtsApi --consumer-version-tag=$1 --no-publish-verification-results --provider-base-url http://localhost:3000 --provider-states-setup-url http://localhost:3000/api/pact_states
}
