FROM mtangaro/docker-galaxycloud

MAINTAINER ma.tangaro@ibiom.cnr.it

ENV container docker

COPY ["playbook.yaml","/"]

RUN ansible-galaxy install indigo-dc.cvmfs-client
RUN ansible-galaxy install indigo-dc.galaxycloud-refdata

ADD https://raw.githubusercontent.com/indigo-dc/Reference-data-galaxycloud-repository/master/cvmfs_server_keys/elixir-italy.galaxy.refdata.pub /tmp/elixir-italy.galaxy.refdata.pub

RUN echo "localhost" > /etc/ansible/hosts

RUN ansible-playbook /playbook.yaml

EXPOSE 21 80

CMD /etc/init.d/vmcontext start; mount -t cvmfs elixir-italy.galaxy.refdata /refdata/elixir-italy.galaxy.refdata; /usr/local/bin/galaxy-startup; /usr/bin/sleep infinity
