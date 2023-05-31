alias k='kubectl'
alias kg='kubectl get '
alias kd='kubectl describe'
alias krm='kubectl delete '
alias k-monitor='k get deployments -o wide'
alias k-get-events='k get events --sort-by=".metadata.creationTimestamp"'

alias vault-stg="export VAULT_ADDR=\"https://vault-stg.internal.workableops.net:8443/\""
alias vault-prod="export VAULT_ADDR=\"https://vault.internal.workableops.net:8443/\""

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/homebrew/share/google-cloud-sdk/completion.zsh.inc'; fi

source <(stern --completion=zsh)

function kctx(){
 kubectx $1 && source ~/.bash_profile
}

function ls_images(){
  gcloud --project staging-artifacts-786a container images list-tags gcr.io/staging-artifacts-786a/$1
}

function kg_dep_image(){
 kubectl get deployments -o wide | grep $1 | awk '{print $8}' | uniq
}

function kg_logs(){
 stern $1 -c $1 --exclude health --exclude pg/webhooks --since 1s
}

function flux_logs(){
  POD=$(kubectl -n flux get pods | grep helm-operator | awk '{print $1}')
  kubectl -n flux logs -f $POD
}

function k_node_resources(){
 kubectl get nodes --no-headers | awk '{print $1}' | xargs -I {} sh -c 'echo {}; kubectl describe node {} | grep Allocated -A 5 | grep -ve Event -ve Allocated -ve percent -ve -- ; echo'
}

function add_k8s_project(){
 PROJECT_ID=$1
 gcloud config set project "${PROJECT_ID}"
 CLUSTER_NAME=`gcloud container clusters list --format="value(name)" --sort-by=NAME --limit=1`
 ZONE=`gcloud container clusters list --format="value(location)" --sort-by=NAME --limit=1`
 gcloud container clusters get-credentials "${CLUSTER_NAME}" --zone "${ZONE}" --project "${PROJECT_ID}"
}

function scale_up_k8s_project(){
 PROJECT_ID=$1
 gcloud config set project "${PROJECT_ID}"
 CLUSTER_NAME=`gcloud container clusters list --format="value(name)" --sort-by=NAME --limit=1`
 ZONE=`gcloud container clusters list --format="value(location)" --sort-by=NAME --limit=1`
 gcloud container clusters get-credentials "${CLUSTER_NAME}" --zone "${ZONE}" --project "${PROJECT_ID}"
 yes | gcloud container clusters resize "${CLUSTER_NAME}" --project "${PROJECT_ID}" --node-pool nodepool1 --num-nodes 1 --region "${ZONE}" | gnomon --medium=1.0 --high=4.0 --ignore-blank --real-time=100
}

function scale_down_k8s_project(){
 PROJECT_ID=`gcloud projects list --filter "project_id=*'workable'\$1*" --format="value(project_id)"`
 gcloud config set project "${PROJECT_ID}"
 CLUSTER_NAME=`gcloud container clusters list --format="value(name)" --sort-by=NAME --limit=1`
 ZONE=`gcloud container clusters list --format="value(location)" --sort-by=NAME --limit=1`
 gcloud container clusters get-credentials "${CLUSTER_NAME}" --zone "${ZONE}" --project "${PROJECT_ID}"
 yes | gcloud container clusters resize "${CLUSTER_NAME}" --project "${PROJECT_ID}" --node-pool nodepool1 --num-nodes 0 --region "${ZONE}" | gnomon --medium=1.0 --high=4.0 --ignore-blank --real-time=100
}

function get_pod_events(){
 kubectl get event  --field-selector involvedObject.name=$1
}

function kubectlgetall {
  for i in $(kubectl api-resources --verbs=list --namespaced -o name | grep -v "events.events.k8s.io" | grep -v "events" | sort | uniq); do
    echo "Resource:" $i
    kubectl -n ${1} get --ignore-not-found ${i} -l ${2}
  done
}

function restart_deployment(){
 kubectl get deployments | grep $1 | awk {'print $1'} | xargs -I{} kubectl rollout restart deployment/{}
}

function secrets() {
  if [[ $1 = stg* ]]
  then
    echo ormos envs vars get /staging/workable$1/$2 --values
    ormos envs vars get /staging/workable$1/$2 --values
  else
    echo ormos envs vars get /staging/$1/$2 --values
    ormos envs vars get /staging/$1/$2 --values
  fi
}
