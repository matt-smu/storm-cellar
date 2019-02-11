SHELL:=/bin/bash
# SHELL:=/bin/bash -o pipefail

#ALPINE_MAJOR=3.6
#ALPINE_VERSION=3.6.1
ALPINE_MAJOR=3.7
ALPINE_VERSION=3.7.0
ALPINE_ARCH=x86_64

ALPINE_TAR=alpine-minirootfs.tar.gz
JRE_TAR_REMOTE=sgxlkl_openjdk_jre_alpine_8.121.13-r0.tar.gz
#JRE_TAR=jre8-no-segv-nommap.tar.gz
JRE_TAR=../$(JRE_TAR_REMOTE)

ROOT_FS=sgxlkl-java-fs.img
MOUNTPOINT=/media/ext4disk
#IMAGE_SIZE_MB=400
IMAGE_SIZE_MB=700

ESCALATE_CMD=sudo

#LOCAL_CLUSTER=
LOCAL_CLUSTER=org.apache.storm.LocalCluster

#STORM_RELEASE_VERSION=apache-storm-1.2.2
STORM_RELEASE_VERSION=apache-storm-2.0.0
STORM_RELEASE_TAR=${STORM_RELEASE_VERSION}.tar.gz
STORM_HOME_DIR=${STORM_RELEASE_VERSION}
STORM_LIB_DIR=${STORM_HOME_DIR}/lib
STORM_EG_DIR=${STORM_HOME_DIR}/examples/storm-starter/src/jvm/org/apache/storm/starter
STORM_EG_SRC=ExclamationTopology.java
STORM_EG_CLASS=org.apache.storm.starter.ExclamationTopology
#STORM_EG_SRC=WordCountTopology.java
#STORM_EG_CLASS=org.apache.storm.starter.WordCountTopology

#ZK_RELEASE_TAR=zookeeper-3.4.12.tar.gz
#ZK_HOME_DIR=zookeeper-3.4.12
#ZK_LIB_DIR=${ZK_HOME_DIR}/lib


RUN_COMMENT=storm2_exclaim
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
  SGXLKL_HOSTNAME=localhost \
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
  -Dstorm.conf.file= \
  -Dstorm.jar=/app/storm-starter-2.0.0.jar \
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
#	curl -L -o "$@" "https://nl.alpinelinux.org/alpine/v${ALPINE_MAJOR}/releases/${ALPINE_ARCH}/alpine-minirootfs-${ALPINE_VERSION}-${ALPINE_ARCH}.tar.gz"
	curl -L -o "$@" "https://nl.alpinelinux.org/alpine/v$(ALPINE_MAJOR)/releases/$(ALPINE_ARCH)/alpine-minirootfs-$(ALPINE_VERSION)-$(ALPINE_ARCH).tar.gz"



${STORM_RELEASE_TAR}:
#	curl -L -o "$@" "http://mirror.vorboss.net/apache/storm/apache-storm-1.2.2/apache-storm-1.2.2.tar.gz"
	cp /opt/storm_20/storm-dist/binary/final-package/target/${STORM_RELEASE_TAR} ${CURDIR}

${ZK_RELEASE_TAR}:
	curl -L -o "$@" "http://mirror.ox.ac.uk/sites/rsync.apache.org/zookeeper/stable/zookeeper-3.4.12.tar.gz"

storm-deps: ${STORM_RELEASE_TAR} 
	tar -C ${CURDIR} -xf ${STORM_RELEASE_TAR}
	[ -d ${CURDIR}/app/lib ] ||mkdir -p ${CURDIR}/app/lib
	[ -d ${CURDIR}/app/logs ] ||mkdir -p ${CURDIR}/app/logs
#	[ -d ${CURDIR}/app/storm-local ] ||mkdir -p ${CURDIR}/app/storm-local
	[ -d ${CURDIR}/app/storm ] ||mkdir -p ${CURDIR}/app/storm
#	[ -d ${CURDIR}/app/zk/data ] ||mkdir -p ${CURDIR}/app/zk/data
	cp  ${CURDIR}/${STORM_LIB_DIR}/*.jar ${CURDIR}/app/lib
	cp  ${CURDIR}/storm-starter-2.0.0.jar ${CURDIR}/app
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

Example.class: storm-deps 
	echo "Compiling ${CURDIR}/${STORM_EG_DIR}/${STORM_EG_SRC}"
	#javac -classpath ${CURDIR}/${STORM_LIB_DIR}/*:${CURDIR}/storm-starter-1.2.2.jar:. -d ${CURDIR}/app ${CURDIR}/${STORM_EG_DIR}/${STORM_EG_SRC} 
	javac -classpath ${CURDIR}/${STORM_LIB_DIR}/*:. -d ${CURDIR}/app ${CURDIR}/${STORM_EG_DIR}/${STORM_EG_SRC} 

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
		chroot ${MOUNTPOINT} /bin/sh /usr/sbin/buildenv.sh; \
                umount ${MOUNTPOINT}; \
                chown ${USER} "$@"; \
'

STORM2_HOME_DIR=${STORM_RELEASE_VERSION}
STORM2_LIB_DIR=${STORM2_HOME_DIR}/lib
STORM2_EG_DIR=${STORM2_HOME_DIR}/examples/storm-starter/src/jvm/org/apache/storm/starter
STORM2_EG_SRC=ExclamationTopology.java
STORM2_EG_CLASS=org.apache.storm.starter.ExclamationTopology

#storm2-deps:
#	[ -d ${CURDIR}/app/lib ] ||mkdir -p ${CURDIR}/app/lib
#	[ -d ${CURDIR}/app/logs ] ||mkdir -p ${CURDIR}/app/logs
#	[ -d ${CURDIR}/app/storm-local ] ||mkdir -p ${CURDIR}/app/storm-local
#	[ -d ${CURDIR}/app/storm ] ||mkdir -p ${CURDIR}/app/storm
#	[ -d ${CURDIR}/app/zk/data ] ||mkdir -p ${CURDIR}/app/zk/data
#	cp  ${CURDIR}/${STORM2_LIB_DIR}/*.jar ${CURDIR}/app/lib
	#cp  ${CURDIR}/storm.yaml ${CURDIR}/app/
	#cp  ${CURDIR}/log4j2.xml ${CURDIR}/app/
	#cp  ${CURDIR}/cluster.xml ${CURDIR}/app/
	#cp  ${CURDIR}/worker.xml ${CURDIR}/app/
#	echo "Compiling ${CURDIR}/${STORM2_EG_DIR}/${STORM2_EG_SRC}"
	#javac -classpath ${CURDIR}/${STORM_LIB_DIR}/*:${CURDIR}/storm-starter-1.2.2.jar:. -d ${CURDIR}/app ${CURDIR}/${STORM_EG_DIR}/${STORM_EG_SRC} 
#	javac -classpath ${CURDIR}/${STORM2_LIB_DIR}/*:. -d ${CURDIR}/app ${CURDIR}/${STORM2_EG_DIR}/${STORM2_EG_SRC}

storm2: ${ROOT_FS}
	echo "Running storm2 enclave example:"
	LD_LIBRARY_PATH=${LD_LIBRARY_PATH} ${SGXLKL_PARAMS} ${CURDIR}/../../../build/sgx-lkl-run ${CURDIR}/${ROOT_FS} /opt/j2re-image/bin/java ${JVM_PARAMS} ${JAVA_PARAMS} ${APP_PARAMS} ${LOCAL_CLUSTER} ${STORM2_EG_CLASS} ${TEE2LOG}


test: ${ROOT_FS}
	echo "Running storm enclave example:"
	LD_LIBRARY_PATH=${LD_LIBRARY_PATH} ${SGXLKL_PARAMS} ${CURDIR}/../../../build/sgx-lkl-run ${CURDIR}/${ROOT_FS}  /opt/j2re-image/bin/java ${JVM_PARAMS} ${JAVA_PARAMS} ${APP_PARAMS} ${LOCAL_CLUSTER} ${STORM_EG_CLASS} ${TEE2LOG}

test_gdb: ${ROOT_FS}
	echo "Running storm Hello World example under gdb:"
	LD_LIBRARY_PATH=${LD_LIBRARY_PATH} ${SGX_PARAMS} ../../../gdb/sgx-lkl-gdb --args ${CURDIR}/../../../build/sgx-lkl-run ${CURDIR}/${ROOT_FS}  /opt/j2re-image/bin/java ${JVM_PARAMS} ${JAVA_PARAMS} ${APP_PARAMS} org.apache.storm.starter.ExclamationTopology
