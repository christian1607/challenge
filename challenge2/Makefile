MYPROJECT=challenge-project-291102
JSON_CREDENTIAL=sa-credentials.json
REGION=us-central1
ZONE=us-central1-a
TAG=latest
BIN_GCLOUD=gcloud
CLUSTER_NAME=my-gke-cluster
PRIVATE_KEY=key
VM_USERNAME=centosjenkins

create_vm:
	export GOOGLE_CLOUD_PROJECT=${MYPROJECT} && \
	export GOOGLE_CLOUD_KEYFILE_JSON=${JSON_CREDENTIAL} && \
	export GCLOUD_REGION=${REGION} && \
	export GCLOUD_ZONE=${ZONE} && \
	terraform init && \
	terraform apply -var="vm_username=${VM_USERNAME}"

destroy_vm:
	export GOOGLE_CLOUD_PROJECT=${MYPROJECT} && \
	export GOOGLE_CLOUD_KEYFILE_JSON=${JSON_CREDENTIAL} && \
	export GCLOUD_REGION=${REGION} && \
	export GCLOUD_ZONE=${ZONE} && \
	terraform destroy -var="vm_username=${VM_USERNAME}"
install_jenkins:
	echo "JENKINS ansible_host=$(shell terraform output ip)" > hosts && \
	ansible-playbook  playbook.yml -i hosts	 --extra-vars "ansible_user=${VM_USERNAME}" --private-key=${PRIVATE_KEY}

gey_jenkins_admin_password:
	ansible JENKINS -i hosts -b -a "cat /var/lib/jenkins/secrets/initialAdminPassword" --extra-vars "ansible_user=${VM_USERNAME}" --private-key=${PRIVATE_KEY}

test_ansible:
	echo "JENKINS ansible_host=$(shell terraform output ip)" > hosts
	