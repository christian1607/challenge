MYPROJECT=challenge-project-291102
JSON_CREDENTIAL=sa-credentials.json
REGION=us-central1
ZONE=us-central1-a
TAG=latest
BIN_GCLOUD=gcloud
CLUSTER_NAME=my-gke-cluster

create_cluster_k8s:
	export GOOGLE_CLOUD_PROJECT=${MYPROJECT} && \
	export GOOGLE_CLOUD_KEYFILE_JSON=${JSON_CREDENTIAL} && \
	export GCLOUD_REGION=${REGION} && \
	export GCLOUD_ZONE=${ZONE} && \
	terraform init && \
	terraform apply -auto-approve -var="cluster_name=${CLUSTER_NAME}"

destroy_cluster_k8s:
	export GOOGLE_CLOUD_PROJECT=${MYPROJECT} && \
	export GOOGLE_CLOUD_KEYFILE_JSON=${JSON_CREDENTIAL} && \
	export GCLOUD_REGION=${REGION} && \
	export GCLOUD_ZONE=${ZONE} && \
	terraform init && \
	terraform destroy -var="cluster_name=${CLUSTER_NAME}"

install_ingress_controller:
	export GCLOUD_REGION=${REGION} && \
	export GCLOUD_ZONE=${ZONE} && \
	${BIN_GCLOUD} container clusters get-credentials ${CLUSTER_NAME}   --zone=${ZONE} && \
	helm repo add nginx https://helm.nginx.com/stable && \
	helm install nginx nginx/nginx-ingress

config_registry_gcr:
	kubectl create secret docker-registry gcr-json-key --docker-server=gcr.io --docker-username=_json_key --docker-password='$(shell cat sa-credentials.json)' --docker-email=any@gmail.com

build_imagen:
	docker build -t gcr.io/${MYPROJECT}/mypythonapp:${TAG} -f python-api/Dockerfile python-api

push_imagen:
	export GOOGLE_CLOUD_PROJECT=${MYPROJECT} && \
	export GOOGLE_CLOUD_KEYFILE_JSON=${JSON_CREDENTIAL} && \
	export GCLOUD_REGION=${REGION} && \
	export GCLOUD_ZONE=${ZONE} && \
	${BIN_GCLOUD} auth configure-docker && \
	docker push gcr.io/${MYPROJECT}/mypythonapp:${TAG}

deploy_api_k8s:
	kubectl apply -f python-api/k8s/deployment.yml && \
	kubectl set image deploy app-deployment app-container='gcr.io/${MYPROJECT}/mypythonapp:${TAG}'
