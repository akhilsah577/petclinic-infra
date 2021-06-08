#!/usr/bin/env bash

#### Description: Script to install and configure Jenkins master

set -o errexit
set -o pipefail
set -o nounset
set -o xtrace

main(){
        update_yum_packages
        install_java_jdk
        install_wget
        add_jenkins_yum_repo
        import_jenkins_key
        install_jenkins
        start_jenkins_service
}

update_yum_packages(){
        sudo yum -y update
}

install_java_jdk(){
        sudo yum remove -y java
        sudo yum install -y ${jenkins_java_version}
}

install_wget() {
        sudo yum install -y wget
}
add_jenkins_yum_repo(){
        sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
}


import_jenkins_key(){
        sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
        sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
}

install_jenkins(){
        sudo yum upgrade
        sudo yum install -y jenkins
}


start_jenkins_service(){
        sudo systemctl daemon-reload
        sudo systemctl start jenkins
}

main "$@"
