SHELL:=/bin/bash
# SHELL:=/bin/bash -o pipefail

SGX_LKL_HOME=/opt/sgx-lkl/sgx-lkl

ALPINE_MAJOR=3.7
ALPINE_VERSION=3.7.0
ALPINE_ARCH=x86_64

ALPINE_TAR=alpine-minirootfs.tar.gz
JRE_TAR_REMOTE=sgxlkl_openjdk_jre_alpine_8.121.13-r0.tar.gz
#JRE_TAR=jre8-no-segv-nommap.tar.gz
JRE_TAR=../$(JRE_TAR_REMOTE)

ROOT_FS=sgxlkl-java-fs.img
MOUNTPOINT=/media/ext4disk
IMAGE_SIZE_MB=2000

ESCALATE_CMD=sudo

SGXLKL_HOSTNAME=worker01
LOOP_DEVICE=loop9
SGXLKL_IP4=10.0.1.1
SGXLKL_TAP=sgxlkl_tap0

#LOCAL_CLUSTER=
LOCAL_CLUSTER=org.apache.storm.LocalCluster

#STORM_HOME=/opt/storm_20
STORM_RELEASE_HOME=/opt/storm-cellar/storm
STORM_VERSION=2.0.1-SNAPSHOT
STORM_RELEASE_VERSION=apache-storm-${STORM_VERSION}
STORM_RELEASE_TAR=${STORM_RELEASE_VERSION}.tar.gz
STORM_HOME_DIR=${STORM_RELEASE_VERSION}
STORM_LIB_DIR=${STORM_HOME_DIR}/lib
STORM_TOPO_JAR=storm-starter-${STORM_VERSION}.jar
STORM_TOPO_CLASS=org.apache.storm.starter.ExclamationTopology
STORM_CONF=storm.yaml

RUN_COMMENT=storm2_dist
LOGPATH=${CURDIR}/log
LOGFILE=${LOGPATH}/${shell date +'%Y.%m.%d-%H:%M:%S'}${suffix ${STORM_EG_CLASS}}_${RUN_COMMENT}.log
TEE2LOG=
#TEE2LOG= 2>&1 | tee ${LOGFILE}

#STORM_DEPS= \
	clojure-1.7.0.jar \
	log4j-api-2.8.2.jar \
	log4j-slf4j-impl-2.8.2.jar \
	objenesis-2.1.jar \
	storm-core-1.2.2.jar \
	disruptor-3.3.2.jar \
	log4j-core-2.8.2.jar \
	metrics-core-3.1.0.jar \
	servlet-api-2.5.jar \
	kryo-3.0.3.jar \
	log4j-over-slf4j-1.6.6.jar \
	minlog-1.3.0.jar \
	slf4j-api-1.7.21.jar \

LD_LIBRARY_PATH=/opt/j2re-image/lib/amd64:/opt/j2re-image/lib/amd64/jli:/opt/j2re-image/lib/amd64/server 

SGXLKL_PARAMS=\
  SGXLKL_TAP=sgxlkl_tap0 \
  SGXLKL_HD=${PWD}/${SGXLKL_ROOTFS} \
  SGXLKL_VERSION=1 \
  SGXLKL_CMDLINE="mem=364M" \
  SGXLKL_ESLEEP=1 \
  SGXLKL_SSLEEP=4000 \
  SGXLKL_ESPINS=50000 \
  SGXLKL_SSPINS=500 \
  SGXLKL_STHREADS=2 \
  SGXLKL_ETHREADS=2 \
  SGXLKL_TRACE_SYSCALL=0 \
  SGXLKL_VERBOSE=1 \
  SGXLKL_TRACE_MMAP=0 \
  SGXLKL_HEAP=3200M \
  SGXLKL_STACK_SIZE=8M \
  SGXLKL_KEY=../../../build/config/enclave_debug.key \
  SGXLKL_HOSTNAME=worker01 \
  SGXLKL_TRACE_THREAD=0 \
  SGXLKL_PRINT_HOST_SYSCALL_STATS=1 \
  SGXLKL_NON_PIE=0 \
  GXLKL_GETTIME_VDSO=0 \
  SGXLKL_SIGPIPE=1 

# SGXLKL_PRINT_HOST_SYSCALL_STATS=1
# GXLKL_GETTIME_VDSO=0
# SGXLKL_CMDLINE="mem=80M"
# SGXLKL_TRACE_THREAD=1 \
# SGXLKL_STACK_SIZE=3097152 \
# SGXLKL_HEAP=1919715200 \
# SGXLKL_ESLEEP=1 \
# SGXLKL_SSLEEP=4000 \
# SGXLKL_ESPINS=50000 \
# SGXLKL_SSPINS=500 \
# SGXLKL_HEAP=1060270000 \
# SGXLKL_HEAP=1919715200 \

JVM_PARAMS=\
  -XX:+UseMembar \
  -XX:InitialCodeCacheSize=32m \
  -XX:ReservedCodeCacheSize=32m \
  -Xms64m \
  -Xmx64m \
  -XX:+UseCompressedClassPointers \
  -XX:CompressedClassSpaceSize=64m \
  -XX:MaxMetaspaceSize=64m \
  -XX:+AssumeMP \
  -XX:+PreserveFramePointer \
  -Xdebug \
  -XX:-PrintGC \
  -XX:+UnlockDiagnosticVMOptions \
  -XX:ParallelGCThreads=1 \
  -XX:+DebugNonSafepoints \
  -XX:-UseConcMarkSweepGC \
  -XX:+LogEvents

#JVM_PARAMS=\
  -XX:+UseMembar \
  -XX:InitialCodeCacheSize=2000k \
  -XX:ReservedCodeCacheSize=2000K \
  -Xms2000k \
  -XX:ParallelGCThreads=4 \
  -XX:+UseConcMarkSweepGC \
  -Xmx3000k \
  -XX:CompressedClassSpaceSize=2000K \
  -XX:MaxMetaspaceSize=100M \
  -XX:+UseCompressedClassPointers \
  -XX:+AssumeMP \
  -XX:ParallelGCThreads=4 \
  -XX:+PreserveFramePointer \
  -XX:+TraceSafepoint \
  -Xdebug \
  -XX:+UnlockDiagnosticVMOptions \
  -XX:+DebugNonSafepoints \
  -XX:+UseTransparentHugePages \
  -XX:+UseG1GC \
  -XX:+PrintGC

#  -XX:+PrintCompilation
#  -XX:OnError="gdb - %p" \

CLASSPATH=/app/*:/app/lib/*:.

JAVA_PARAMS=\
  -client \
  -cp ${CLASSPATH}

#  -Djava.io.tmpdir=/app/tmp
# verbose 

APP_PARAMS=\
  -Ddaemon.name= \
  -Dstorm.options= \
  -Dstorm.home=/app \
  -Dstorm.log.dir=/app/logs \
  -Dstorm.conf.file=/app/conf/storm.yaml \
  -Dstorm.jar=/app/${STORM_TOPO_JAR} \
  -Dstorm.dependency.jars= \
  -Dstorm.dependency.artifacts={} \
  -Dlogging.sensitivity=DEBUG \
  -Djava.net.preferIPv4Stack=true \
 

#  -Dsupervisor.blobstore.download.thread.count=5 \
#  -Dstorm.jar=/app/storm-starter-1.2.2.jar \
#  -Dsupervisor.worker.shutdown.sleep.secs=30 \

.DELETE_ON_ERROR:
.PHONY: all clean

all: ${ROOT_FS}

clean:
	test -f HelloWorld.class && rm HelloWorld.class || true
	test -f ${ROOT_FS} && rm ${ROOT_FS} || true
	test -d ${CURDIR}/app && rm -rf ${CURDIR}/app || true

${ALPINE_TAR}:
	curl -L -o "$@" "https://nl.alpinelinux.org/alpine/v$(ALPINE_MAJOR)/releases/$(ALPINE_ARCH)/alpine-minirootfs-$(ALPINE_VERSION)-$(ALPINE_ARCH).tar.gz"


${STORM_RELEASE_TAR}: 
	# storm is git cloned and dist built in STORM_HOME
	test -f ${STORM_RELEASE_HOME}/storm-dist/binary/final-package/target/${STORM_RELEASE_TAR} && cp ${STORM_RELEASE_HOME}/storm-dist/binary/final-package/target/${STORM_RELEASE_TAR} ${CURDIR} || true

${STORM_TOPO_JAR}:
	test -f ${STORM_RELEASE_HOME}/examples/storm-starter/target/${STORM_TOPO_JAR} && cp ${STORM_RELEASE_HOME}/examples/storm-starter/target/${STORM_TOPO_JAR} ${CURDIR} || true

setup-tap: clean-tap
	sudo ip tuntap add dev sgxlkl_tap0 mode tap user `whoami`
	sudo ip link set dev sgxlkl_tap0 up
	sudo ip addr add dev sgxlkl_tap0 10.0.1.254/24

clean-tap:
	if ip a | grep 'sgxlkl_tap0' ; then ip link delete sgxlkl_tap0; else echo 'no tap exists'; fi

kill-java:
	jps |  awk '{print $1}' | xargs kill -9

set-host-net:
	echo "config host net"	

set-hostname:
	echo nimbus01 > /etc/hostname
	hostname -F /etc/hostname
	echo 10.0.1.254 nimbus01 >> /etc/hosts
	#echo 127.0.0.1 nimbus01 >> /etc/hosts
	# https://github.com/gliderlabs/docker-alpine/issues/367
	#echo "hosts: files dns" > /etc/nsswitch.conf
	

storm-deps: ${STORM_RELEASE_TAR} ${STORM_TOPO_JAR}
	tar -C ${CURDIR} -xf ${STORM_RELEASE_TAR}
	[ -d ${CURDIR}/app/lib ] ||mkdir -p ${CURDIR}/app/lib
	[ -d ${CURDIR}/app/logs ] ||mkdir -p ${CURDIR}/app/logs
	[ -d ${CURDIR}/app/conf ] ||mkdir -p ${CURDIR}/app/conf
	#[ -d ${CURDIR}/app/storm ] ||mkdir -p ${CURDIR}/app/storm
	cp  ${CURDIR}/${STORM_LIB_DIR}/*.jar ${CURDIR}/app/lib
	cp  ${CURDIR}/${STORM_TOPO_JAR} ${CURDIR}/app
	sed -e "s/storm.local.hostname: \"nimbus01\"/storm.local.hostname: \"worker01\"/" ${STORM_CONF} > ${CURDIR}/app/conf/storm.yaml
#	cp  ${CURDIR}/storm.yaml ${CURDIR}/app/
#	cp  ${CURDIR}/log4j2.xml ${CURDIR}/app/
#	cp  ${CURDIR}/cluster.xml ${CURDIR}/app/
#	cp  ${CURDIR}/worker.xml ${CURDIR}/app/


#	cp ${CURDIR}/storm-starter-1.2.2.jar ${CURDIR}/app/lib

#zk-deps: ${ZK_RELEASE_TAR}
#	tar -C ${CURDIR} -xf ${ZK_RELEASE_TAR}
#	[ -d ${CURDIR}/zk/lib ] ||mkdir -p ${CURDIR}/zk/lib
#	cp  ${CURDIR}/${ZK_LIB_DIR}/*.jar ${CURDIR}/zk/lib
#	echo "tickTime=2000" > ${CURDIR}/zk/zoo.cfg
#	echo "dataDir=/app/zk/data" >> ${CURDIR}/zk/zoo.cfg
#	echo "clientPort=2181" >> ${CURDIR}/zk/zoo.cfg
#	cp  ${CURDIR}/*.conf ${CURDIR}/zk/
#       cp ${CURDIR}/storm-starter-1.2.2.jar ${CURDIR}/app/lib

        
#ExclamationTopology.class: storm-deps
#	javac -classpath ${CURDIR}/${STORM_LIB_DIR}/*:. -d ${CURDIR}/app ${CURDIR}/${STORM_HOME_DIR}/examples/storm-starter/src/jvm/org/apache/storm/starter/ExclamationTopology.java

#Example.class: storm-deps 
#	echo "Compiling ${CURDIR}/${STORM_EG_DIR}/${STORM_EG_SRC}"
	#javac -classpath ${CURDIR}/${STORM_LIB_DIR}/*:${CURDIR}/storm-starter-1.2.2.jar:. -d ${CURDIR}/app ${CURDIR}/${STORM_EG_DIR}/${STORM_EG_SRC} 
#	javac -classpath ${CURDIR}/${STORM_LIB_DIR}/*:. -d ${CURDIR}/app ${CURDIR}/${STORM_EG_DIR}/${STORM_EG_SRC} 

#${ROOT_FS}: ${ALPINE_TAR} buildenv.sh Example.class zk-deps
${ROOT_FS}: ${ALPINE_TAR} buildenv.sh storm-deps
	dd if=/dev/zero of="$@" count=${IMAGE_SIZE_MB} bs=1M
	mkfs.ext4 "$@"
	${ESCALATE_CMD} /bin/bash -euxo pipefail -c '\
                mkdir -p ${MOUNTPOINT}; \
                mount -t ext4 -o loop "$@" ${MOUNTPOINT}; \
                tar -C ${MOUNTPOINT} -xvf ${ALPINE_TAR}; \
                cp /etc/resolv.conf ${MOUNTPOINT}/etc/resolv.conf; \
                install buildenv.sh ${MOUNTPOINT}/usr/sbin; \
                mkdir -p ${MOUNTPOINT}/app/lib; \
                mkdir -p ${MOUNTPOINT}/app/tmp; \
                cp -pvR ${CURDIR}/app/* ${MOUNTPOINT}/app; \
		mkdir -p ${MOUNTPOINT}/opt; \
                [ -f ../${JRE_TAR} ] || curl -L -o ../${JRE_TAR} "https://lsds.doc.ic.ac.uk/files/${JRE_TAR_REMOTE}"; \
                tar -xf ../${JRE_TAR} -C ${MOUNTPOINT}/opt; \
		curl -L -o "${MOUNTPOINT}/opt/j2re-image/lib/amd64/server/libjvm.so-gdb.py" "https://icedtea.classpath.org/people/adinn/unwinder/file/f50e52519fb9/dbg8.py"; \
        	echo "worker01"  > ${MOUNTPOINT}/etc/hostname; \
		echo "10.0.1.1 worker01" >> ${MOUNTPOINT}/etc/hosts; \
		echo "10.0.1.254 nimbus01" >> ${MOUNTPOINT}/etc/hosts; \
		echo "hosts: files dns" > ${MOUNTPOINT}/etc/nsswitch.conf; \
		chroot ${MOUNTPOINT} /bin/sh /usr/sbin/buildenv.sh; \
                umount ${MOUNTPOINT}; \
                chown ${USER} "$@"; \
'

storm_local: ${ROOT_FS} ${STORM_TOPO_JAR}
	echo "Running storm2 aio(local) enclave example:"
	LD_LIBRARY_PATH=${LD_LIBRARY_PATH} ${SGXLKL_PARAMS} ${SGX_LKL_HOME}/build/sgx-lkl-run ${CURDIR}/${ROOT_FS} /opt/j2re-image/bin/java ${JVM_PARAMS} ${JAVA_PARAMS} ${APP_PARAMS} ${LOCAL_CLUSTER} ${STORM_TOPO_CLASS} ${TEE2LOG}

storm_supervisor: ${ROOT_FS} setup-tap
	echo "Running storm2 dist enclave example:"
	LD_LIBRARY_PATH=${LD_LIBRARY_PATH} ${SGXLKL_PARAMS} ${SGX_LKL_HOME}/build/sgx-lkl-run ${CURDIR}/${ROOT_FS}  /opt/j2re-image/bin/java ${JVM_PARAMS} -server -cp ${CLASSPATH} -Ddaemon.name=supervisor -Dstorm.options= -Dstorm.home=/app -Dstorm.log.dir=/app/logs -Dstorm.conf.file=/app/conf/storm.yaml -Dstorm.jar=/app/${STORM_TOPO_JAR} -Dstorm.dependency.jars= -Dstorm.dependency.artifacts={} -Dlogging.sensitivity=DEBUG -Djava.net.preferIPv4Stack=true -Djava.deserialization.disabled=true -Dlogfile.name=supervisor.log org.apache.storm.daemon.supervisor.Supervisor ${TEE2LOG}

test: ${ROOT_FS}
	echo "Running storm enclave example:"
	LD_LIBRARY_PATH=${LD_LIBRARY_PATH} ${SGXLKL_PARAMS} ${SGX_LKL_HOME}/build/sgx-lkl-run ${CURDIR}/${ROOT_FS}  /opt/j2re-image/bin/java ${JVM_PARAMS} ${JAVA_PARAMS} ${APP_PARAMS} ${LOCAL_CLUSTER} ${STORM_EG_CLASS} ${TEE2LOG}

test_gdb: ${ROOT_FS}
	echo "Running storm Hello World example under gdb:"
	LD_LIBRARY_PATH=${LD_LIBRARY_PATH} ${SGX_PARAMS} ${SGX_LKL_HOME}/gdb/sgx-lkl-gdb --args ${SGX_LKL_HOME}/build/sgx-lkl-run ${CURDIR}/${ROOT_FS}  /opt/j2re-image/bin/java ${JVM_PARAMS} ${JAVA_PARAMS} ${APP_PARAMS} org.apache.storm.starter.ExclamationTopology
