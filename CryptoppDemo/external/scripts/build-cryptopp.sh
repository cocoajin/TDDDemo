#!/bin/bash

if [ ! -n "${PKG_VERSION+1}" ]; then
  PKG_VERSION="5.6.2"
fi
if [ ! -n "${SDK_VERSION+1}" ]; then
  SDK_VERSION=`xcodebuild -showsdks 2>&1 | grep -o 'iOS \d\+\(\.\d\+\)*' | tail -1 | grep -o '\d\+\(\.\d\+\)*'`
fi

#############

PKG_NAME="cryptopp"
LIB_NAME="lib${PKG_NAME}.a"
ARCHIVE_NAME=${PKG_NAME}`echo ${PKG_VERSION} | sed 's/\.//g'`.zip
URL_BASE="https://www.cryptopp.com"
DOWNLOAD_URL=${URL_BASE}/${ARCHIVE_NAME}
XCODE_ROOT=`xcode-select -print-path`
XCODE_VERSION=`xcodebuild -version|awk '/^Xcode/ {print $2}'|sed 's/\.//g'`

WORK_PATH=`cd $(dirname $0) && cd .. && pwd`
#echo ${WORK_PATH}

ARCHS="i386 x86_64 armv7 arm64"
if [ `echo "${SDK_VERSION} - 6.0 >= 0" | bc` == 1 ]; then
  ARCHS="${ARCHS} armv7s"
fi

mkdir -p ${WORK_PATH}/tmp
mkdir -p ${WORK_PATH}/lib
mkdir -p ${WORK_PATH}/include/${PKG_NAME}
mkdir -p ${WORK_PATH}/objs

pushd ${WORK_PATH}/tmp > /dev/null
if [ ! -e ${ARCHIVE_NAME} ]; then
  echo "Downloading ${ARCHIVE_NAME}"
  curl -O ${DOWNLOAD_URL}
else
  echo "Using ${ARCHIVE_NAME}"
fi

HASHCHECK_RESULT=`shasum -c ${WORK_PATH}/scripts/${ARCHIVE_NAME}.sha1`
if [ "${HASHCHECK_RESULT}" != "${ARCHIVE_NAME}: OK" ]; then
  echo "Downloaded file ${ARCHIVE_NAME} is broken. remove it manually and restart build script again"
  exit 1
fi

STATIC_ARCHIVES=""
for ARCH in ${ARCHS}
do
  if [ "${ARCH}" == "i386" -o "${ARCH}" == "x86_64" ]; then
    PLATFORM="iPhoneSimulator"
  else
    PLATFORM="iPhoneOS"
  fi
  export DEV_ROOT="${XCODE_ROOT}/Platforms/${PLATFORM}.platform/Developer" 	
  export SDK_ROOT="${DEV_ROOT}/SDKs/${PLATFORM}${SDK_VERSION}.sdk"
  export TOOLCHAIN_ROOT="${XCODE_ROOT}/Toolchains/XcodeDefault.xctoolchain/usr/bin/"
  BUILD_PATH="${WORK_PATH}/objs/${PLATFORM}${SDK_VERSION}-${ARCH}.sdk"

  export CC=clang
  export CXX=clang++
  export AR=${TOOLCHAIN_ROOT}libtool
  export RANLIB=${TOOLCHAIN_ROOT}ranlib
  export ARFLAGS="-static -o"
  export LDFLAGS="-arch ${ARCH} -isysroot ${SDK_ROOT}"
  export CXXFLAGS="-x c++ -arch ${ARCH} -isysroot ${SDK_ROOT} -I${WORK_PATH}/include/${PKG_NAME} -I${BUILD_PATH}"

  echo "Building ${PKG_NAME} for ${PLATFORM} ${SDK_VERSION} ${ARCH} ..."
  unzip -o ${ARCHIVE_NAME} > /dev/null
  if [ "${PKG_VERSION}" == "5.6.1" ]; then
    patch -p1 < ${WORK_PATH}/scripts/${PKG_NAME}`echo ${PKG_VERSION} | sed 's/\.//g'`.diff
  fi
	
  mkdir -p ${BUILD_PATH}
  mv *.cpp ${BUILD_PATH}
  mv ${BUILD_PATH}/*test* . # move back test files here, which aren't neccesary
  mv *.h ${WORK_PATH}/include/${PKG_NAME}

  LOG="${BUILD_PATH}/build-${PKG_NAME}-${PKG_VERSION}.log"

  pushd ${BUILD_PATH} > /dev/null
  make -f ${WORK_PATH}/scripts/Makefile >> "${LOG}" 2>&1
  popd > /dev/null
  
  STATIC_ARCHIVES="${STATIC_ARCHIVES} ${WORK_PATH}/objs/${PLATFORM}${SDK_VERSION}-${ARCH}.sdk/${LIB_NAME}"
done

echo "Creating universal  library..."
lipo -create ${STATIC_ARCHIVES} -output ${WORK_PATH}/lib/${LIB_NAME}
echo "Build ${LIB_NAME} done."
