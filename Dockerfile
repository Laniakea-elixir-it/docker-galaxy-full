FROM mtangaro/docker-galaxycloud

MAINTAINER ma.tangaro@ibiom.cnr.it

ENV container docker

#COPY ["playbook.yaml","entrypoint.sh","/"] # only for developemnt
COPY ["playbook.yaml","/"]

RUN ansible-galaxy install indigo-dc.galaxycloud-refdata

ADD https://raw.githubusercontent.com/indigo-dc/Reference-data-galaxycloud-repository/master/cvmfs_server_keys/elixir-italy.galaxy.refdata.pub /tmp/elixir-italy.galaxy.refdata.pub

RUN echo "localhost" > /etc/ansible/hosts

RUN ansible-playbook /playbook.yaml

EXPOSE 21 80

#ENTRYPOINT ["/entrypoint.sh"] # only for development

CMD /etc/init.d/vmcontext start; /usr/local/bin/galaxy-startup
