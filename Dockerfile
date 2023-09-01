FROM jupyter/base-notebook:notebook-6.5.4
USER root
# install gpg and curl and other utils
RUN apt-get update -y && apt-get install -y \
    apt-utils \
    gpg \
    curl \
    git \
    vim \
    jq \
    && apt-get clean && rm -rf /var/lib/apt/lists/* \
# install ibmcloud
 && curl -fsSL https://clis.cloud.ibm.com/install/linux | sh
# add passwordless sudo for user for lab
RUN echo "$NB_USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $NB_UID
# install and enable nbgitpuller
RUN pip install nbgitpuller \
 && jupyter serverextension enable --py nbgitpuller --sys-prefix
WORKDIR $HOME
