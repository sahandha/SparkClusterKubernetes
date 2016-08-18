export STACK_NAME=kube_cluster
export NUMBER_OF_MINIONS=2
export MAX_NUMBER_OF_MINIONS=2
export MASTER_FLAVOR=m1.medium
export MINION_FLAVOR=m1.medium
export EXTERNAL_NETWORK=ext-net
export DNS_SERVER=141.142.2.2
export IMAGE_URL_PATH=http://cloud.centos.org/centos/7/images
export IMAGE_FILE=CentOS-7-x86_64-GenericCloud-1510.qcow2
export OPENSTACK_IMAGE_NAME='CentOS7'
#export IMAGE_URL_PATH=http://storage.apps.openstack.org/images/
#export IMAGE_FILE=ubuntu14.04-x64-kubernetes.qcow2
#export OPENSTACK_IMAGE_NAME='Ubuntu14.04'
export SWIFT_SERVER_URL=http://acx.ncsa.illinois.edu:8080/v1/AUTH_418250e57afa473591d99187651b561e
export ENABLE_PROXY=false
export KUBERNETES_PROVIDER=openstack-heat
