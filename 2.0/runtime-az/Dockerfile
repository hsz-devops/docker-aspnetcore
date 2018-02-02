FROM  microsoft/aspnetcore:2.0

# ----------------------------------------------------------------------------------------
# https://docs.microsoft.com/en-us/azure/app-service/containers/app-service-linux-ssh-support
# ----------------------------------------------------------------------------------------
ARG AZ__OPENSSH_SERVER__ENABLE
ENV AZ__OPENSSH_SERVER__ENABLE=${AZ__OPENSSH_SERVER__ENABLE:-0}

ARG AZ__OPENSSH_SERVER__PASSWD
ENV AZ__OPENSSH_SERVER__PASSWD=${AZ__OPENSSH_SERVER__PASSWD:-root:Docker!}

# ----------------------------------------------------------------------------------------
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update \
    && \
    apt-get install -y \
        apt-transport-https \
        lsb-release \
        ca-certificates \
        openssl \
        openssh-server \
        ssl-cert \
        less \
        unzip \
    && \
    apt-get autoremove -y --purge && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    echo "..."

COPY _src/docker-entrypoint-az.sh  /
RUN  chmod -R a+xX                 /docker-entrypoint*.sh

COPY _src/sshd_config /etc/ssh/

EXPOSE 2222
ENTRYPOINT ["/docker-entrypoint-az.sh"]
