openssl genrsa -out ca-key.pem 2048
openssl req -x509 -new -nodes -key ca-key.pem -days 10000 -out ca.pem -subj "/CN=kube-ca"

openssl genrsa -out apiserver-key.pem 2048
openssl req -new -key apiserver-key.pem -out apiserver.csr -subj "/CN=kube-apiserver" -config openssl.cnf
openssl x509 -req -in apiserver.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out apiserver.pem -days 365 -extensions v3_req -extfile openssl.cnf

openssl genrsa -out kubecore-minion1-worker-key.pem 2048
WORKER_IP=141.142.236.183 openssl req -new -key kubecore-minion1-worker-key.pem -out kubecore-minion1-worker.csr -subj "/CN=kubecore-minion1" -config worker-openssl.cnf
WORKER_IP=141.142.236.183 openssl x509 -req -in kubecore-minion1-worker.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out kubecore-minion1-worker.pem -days 365 -extensions v3_req -extfile worker-openssl.cnf


openssl genrsa -out kubecore-minion2-worker-key.pem 2048
WORKER_IP=141.142.236.179 openssl req -new -key kubecore-minion2-worker-key.pem -out kubecore-minion2-worker.csr -subj "/CN=kubecore-minion2" -config worker-openssl.cnf
WORKER_IP=141.142.236.179 openssl x509 -req -in kubecore-minion2-worker.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out kubecore-minion2-worker.pem -days 365 -extensions v3_req -extfile worker-openssl.cnf


openssl genrsa -out admin-key.pem 2048
openssl req -new -key admin-key.pem -out admin.csr -subj "/CN=kube-admin"
openssl x509 -req -in admin.csr -CA ca.pem -CAkey ca-key.pem -CAcreateserial -out admin.pem -days 365
