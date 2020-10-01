# Challenge 1
Este proyecto nos permite levantar un cluster k8s zonal sobre GKE  usando terraform como aprovisionador de la infraestructura

### Requisitos
- Una cuenta en GCP
- La credenciales en formato json del service account con los permisos necesarios.

### Ejecución

Para la ejecucion es obligatorio que se pase como argumentos el nombre del proyecto y el credential.json

```sh
make [TARGET] [ARGS|OPTIONAL]
```
`TIP: Puede usar TAB para el autocompletado de los targets`


Como argumentos del instalador tenemos los siguientes: 

```sh
PROJECT= Nombre del proyecto (challenge-project-291102)
JSON_CREDENTIAL= Archivo JSON de las credenciales del service account (default: sa-credentials.json)
REGION=Region a instalar (default:us-central1)
ZONE= Zona a instalar (default:us-central1-a)
TAG=Tag de la imagen a construir (default:latest)
BIN_GCLOUD= ruta del ejecutable de cli de gcloud (default: gcloud)
CLUSTER_NAME= Nombre del cluster k8s (default: my-gke-cluster)
```
`TIP: Los argumentos son requeridos de acuerdo al target que se desee ejecutar`
