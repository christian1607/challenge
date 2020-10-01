# Challenge 2
Este proyecto nos permite levantar una maquina virtual centos en GCP usando terraform para luego instalar Jenkins 
usando Ansible

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
PRIVATE_KEY= Ruta donde se genera el private key (Por defecto ya viene con las llaves publicas y provadas creadas)
VM_USERNAME= Usuario por el que se conectara mediante SSH  a la VM (Default: centosjenkins)

```
`TIP: Los argumentos son requeridos de acuerdo al target que se desee ejecutar`
