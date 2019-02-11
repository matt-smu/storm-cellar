#!/bin/bash

set -ex

java -server -Ddaemon.name=nimbus -Dstorm.options= -Dstorm.home=/opt/sgx-lkl/sgx-lkl/apps/jvm/3_storm_dist/apache-storm-2.0.0 -Dstorm.log.dir=/opt/sgx-lkl/sgx-lkl/apps/jvm/3_storm_dist/apache-storm-2.0.0/logs -Djava.library.path=/usr/local/lib:/opt/local/lib:/usr/lib:/usr/lib64 -Dstorm.conf.file=/opt/sgx-lkl/sgx-lkl/apps/jvm/3_storm_dist/storm.yaml -cp /opt/sgx-lkl/sgx-lkl/apps/jvm/3_storm_dist/apache-storm-2.0.0/*:/opt/sgx-lkl/sgx-lkl/apps/jvm/3_storm_dist/apache-storm-2.0.0/lib/*:/opt/sgx-lkl/sgx-lkl/apps/jvm/3_storm_dist/apache-storm-2.0.0/extlib/*:/opt/sgx-lkl/sgx-lkl/apps/jvm/3_storm_dist/apache-storm-2.0.0/extlib-daemon/*:/opt/sgx-lkl/sgx-lkl/apps/jvm/3_storm_dist/apache-storm-2.0.0/conf -Xmx1024m -Djava.deserialization.disabled=true -Dlogfile.name=nimbus.log -Dlog4j.configurationFile=/opt/sgx-lkl/sgx-lkl/apps/jvm/3_storm_dist/apache-storm-2.0.0/log4j2/cluster.xml org.apache.storm.daemon.nimbus.Nimbus
