!/bin/bash
set -x
setup_kubectl(){
  curl -o kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/darwin/amd64/kubectl
  mv kubectl /usr/local/bin/
  chmod +x /usr/local/bin/kubectl
  kubectl version --short --client
  if [[ "$?" == 0 ]]; then
  echo "******* kubectl setup done ********"
  else
  echo "******* kubectl setup failed ********"
  fi
}

setup_heptio_authenticator_aws(){
  curl -o heptio-authenticator-aws https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/darwin/amd64/heptio-authenticator-aws
  mv heptio-authenticator-aws /usr/local/bin/
  chmod +x /usr/local/bin/heptio-authenticator-aws
  heptio-authenticator-aws help
  if [[ "$?" == 0 ]]; then
  echo "******* heptio-authenticator-aws setup done ********"
  else
  echo "******* heptio-authenticator-aws setup failed ********"
  fi
}

check_aws_credentials(){
  account_number="$(aws sts get-caller-identity --output text --query 'Account')"
  case "${account_number}" in
    121660731498)
      echo "You are using the *****AWS sandbox***** account"
      ;;
    180165713404)
      echo "You are using ****cdk-aws-digital-business-nonprod **** account"
      ;;
    828373668907)
      echo "You are using ****cdk-aws-dmg-nitra-prod**** account"
      ;;
    140358921891)
      echo "You are using ****ghs_platform_cloud**** account"
      ;;
    *)
      echo "You are using some other AWS account"
      ;;
  esac
}

setup_kubectl
setup_heptio_authenticator_aws
check_aws_credentials
