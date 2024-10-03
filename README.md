# Deploy Docker Services

## group_vars
Содержатся группы сервисов:
```
esbv3conversion
opmessagestosendsms
```
В этих папках содержатся файлы с переменными <br>
для редактирования **compose file** и **appsettings.json** файлов <br>
**Пример файла:** group_vars/esbv3conversion/esbv3conversion.yml
```
# Настройки appsettings.json
PaySystemUri: "http://10.7.88.7:29311"
Url: "http://+:5000"
ConnectionName: "10.7.27.98(1414)"
UserId: "svcgo-espp"
Password: "qspp-pwd"

#--------Yaml File--------#
ekassir_esbv3conversion: repohub.ekassir.com/ekassir.rshb.esbv3conversion:777.24191112841

```

## roles
roles/espp-deploy-services <br>
Содержатся папки с yaml файлами:
```
.
└── espp-deploy-services
    ├── defaults
    │   └── main.yml
    ├── files
    │   ├── deploy_esbv3conversion.sh
    │   ├── deploy_opmessagestosendsms.sh
    │   ├── hosting.json
    │   └── NLog.config
    ├── tasks
    │   ├── esbv.yml
    │   ├── main.yml
    │   └── opmessages.yml
    └── templates
        ├── appsetings_esbv3conversion.json
        ├── appsettings_opmessagestosendsms.json
        ├── deploy_esbv3conversion.yml.j2
        └── deploy_opmessagestosendsms.yml.j2

```

**Обозначения**

- defaults
  - в файле main.yml содержатся переменные по умолчанию для role. Которые будут доступны для всех задач в role.
- files
  - в этой папке лежат файлы которые просто копируются на хост
- tasks
  - в этой папке содержатся yaml файлы с задачами: **esbv.yml** и **opmessages.yml**
  - Файл main.yml служит основным входным файлом для задач роли и может <br>
    включать другие файлы задач. Чтобы можно было запускать с помощью tags опеределеную одну задачу.
- templates
  - в этой папке содержатся jinja2 templates для **compose file** и **appsettings.json** 
    которые подсталяются из group_vars


## inventori.ini
**Содержатся группы для хостов**
```
[hosts]
10.7.88.9 ansible_ssh_user=root

[esbv3conversion:children]
hosts

[opmessagestosendsms:children]
hosts
```

## playbooks.yml
**Содержатся вызов role**
```
---
- hosts: all
  become: yes
  gather_facts: yes

  roles:
    - espp-deploy-services

```
