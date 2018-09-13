FROM laniakeacloud/galaxy:18.05

MAINTAINER ma.tangaro@ibiom.cnr.it

ENV container docker

COPY ["playbook.yaml","/"]

# Add script to install tools without ansible
ADD https://raw.githubusercontent.com/Laniakea-elixir-it/Scripts/master/galaxy_tools/install_tools.docker.17.sh /usr/local/bin/install-tools
RUN chmod +x /usr/local/bin/install-tools

RUN ansible-galaxy install indigo-dc.cvmfs-client
RUN ansible-galaxy install indigo-dc.galaxycloud-refdata

ENV REFDATA_CVMFS_REPOSITORY_NAME=data.galaxyproject.org
ADD https://raw.githubusercontent.com/indigo-dc/Reference-data-galaxycloud-repository/master/cvmfs_server_keys/$REFDATA_CVMFS_REPOSITORY_NAME.pub /tmp/$REFDATA_CVMFS_REPOSITORY_NAME.pub
ADD https://raw.githubusercontent.com/indigo-dc/Reference-data-galaxycloud-repository/master/cvmfs_server_config_files/$REFDATA_CVMFS_REPOSITORY_NAME.conf /tmp/$REFDATA_CVMFS_REPOSITORY_NAME.conf

RUN echo "localhost" > /etc/ansible/hosts

RUN ansible-playbook /playbook.yaml -e 'refdata_provider_type=cvmfs_preconfigured refdata_repository_name=data.galaxyproject.org refdata_cvmfs_repository_name=data.galaxyproject.org'

# This overwrite docker-galaxycloud CMD line
CMD /bin/mount -t cvmfs $REFDATA_CVMFS_REPOSITORY_NAME /cvmfs/$REFDATA_CVMFS_REPOSITORY_NAME; /usr/local/bin/galaxy-startup; /usr/bin/sleep infinity
