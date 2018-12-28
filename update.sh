#!/bin/bash
set -ex

# *************************************************************
# Description: K8s安装部署工具Helm的定制仓库更新所需脚本，
#              1. 安装helm，使用其相关的repo操作工具
#              2. git pull，把./src下的最新的chart打包，copy到./release
#              2. 为./release发布目录生成索引index.yaml
#
# Author:      Hchnr
# Date:        2018-12-26
#
# *************************************************************

base_dir=`pwd`

# *******************************************
# INSTALL helm client tools 
mkdir -p $base_dir/tmp; cd $base_dir/tmp
wget ftp://ftp.shannonai.com/tmp/images/helm-v2.11.0-linux-amd64.tar.gz
tar -zxvf helm-v2.11.0-linux-amd64.tar.gz
cp linux-amd64/helm /usr/local/bin/helm
git clone git@github.com:jiweil/chart-server.git
repo_dir=$base_dir/tmp/ChartRepo

# *******************************************
# TAR chart => .tgz to release
cd $repo_dir/src
chart_dirs=`ls`
chart_dirs=($chart_dirs)
for chart_dir in ${chart_dirs[@]}; do
  helm package $chart_dir || true
done

mkdir -p $repo_dir/release || true
cd $repo_dir/src
chart_tars=`ls | grep tgz`
chart_tars=($chart_tars)
for chart_tar in ${chart_tars[@]}; do
  mv $chart_tar "$repo_dir/release/"
done
rm -rf $base_dir/release
cp -r $repo_dir/release $base_dir/release

# *******************************************
# CREATE index.yaml for chart repo
cd $base_dir/release
helm repo index . --url=https://chart.shannonai.com:4443/release/
mv index.yaml ../release/ || true

cd $base_dir; rm -rf $base_dir/tmp
