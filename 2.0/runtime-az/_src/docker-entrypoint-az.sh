#!/usr/bin/env bash
#
# v1.0.0    2018-02-02    webmaster@highskillz.com
#
# Support SSH on Azure WebServices for Containers on Ubuntu based images
# https://docs.microsoft.com/en-us/azure/app-service/containers/app-service-linux-ssh-support
#
set -e
set -o pipefail
pwd
echo "Entering /docker-entrypoint-az.sh args [$@]"

# exec_via__init() {
#     set -x
#     exec /usr/bin/dumb-init -- "$@"
# }

# instructions for Azure AppService on Linux from
# https://docs.microsoft.com/en-us/azure/app-service/containers/tutorial-custom-docker-image
set -x
if [ "${AZ__OPENSSH_SERVER__ENABLE}" == "1" ]; then
    if [ -n "${AZ__OPENSSH_SERVER__PASSWD}" ]; then
        # configuring SSH to start
        echo "${AZ__OPENSSH_SERVER__PASSWD}" | chpasswd
        echo "cd $(pwd)" >> /etc/bash.bashrc
        #ssh-keygen -A
        service ssh start
    fi
fi

if [ "${ENTRYPOINT_ROOT_DIR}" != "" ]; then
    cd "${ENTRYPOINT_ROOT_DIR}"
    pwd
fi

# using exec to transfer PID 1 to whatever is executed

# # if [ -x /opt/runt/entrypoint-cmd.sh ]; then
# #     set -x
# #     exec /opt/runt/entrypoint-cmd.sh "$@"
# # else
# #     set -x
# #     exec "$@"
# # fi
# exec_via__init "$@"
exec "$@"
