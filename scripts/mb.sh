function k_port_forward_mb_ats(){
  term=ats-web
  pod_name=`kubectl get -A pods | grep $term | awk {'print $2'}`
  kubectl port-forward $pod_name 8080:2525
}