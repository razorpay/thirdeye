#!/bin/bash

# [Optional] Uncomment below lines to build with latest Pinot changes
# cd ..
# mvn install -DskipTests -pl pinot-common,pinot-core,pinot-spi,pinot-java-client -am -Pbuild-shaded-jar || exit 1
# cd thirdeye

#PROFILES_ARG=""

#if [ $# -ne 0 ]
#then
#PROFILES_ARG="-P "
#for var in "$@"
#do
#  echo "*******************************************************"
#  echo "Preparing build for custom datasource: $var"
#  echo "*******************************************************"
#  PROFILES_ARG=${PROFILES_ARG}${var},
#  case ${var} in
#  # [Optional] add your maven profile name and corresponding custom build here
#  bigquery)
#    # change driver version if need be. Default value is the recommended, tested version.
#    BQ_DRIVER_VERSION=${BQ_DRIVER_VERSION:="SimbaJDBCDriverforGoogleBigQuery42_1.2.4.1007"}
#    wget -N https://storage.googleapis.com/simba-bq-release/jdbc/${BQ_DRIVER_VERSION}.zip
#    unzip -o ${BQ_DRIVER_VERSION}.zip -d ./${BQ_DRIVER_VERSION}
#    # install bigQuery driver
#    mvn install:install-file -Dfile=./${BQ_DRIVER_VERSION}/GoogleBigQueryJDBC42.jar -DgroupId='com.simba.googlebigquery' -DartifactId='jdbc42' -Dversion='1.2.4' -Dpackaging='jar'
#    rm -r -d  -f ./${BQ_DRIVER_VERSION}
#    ;;
#  *)
#    echo "Unkown custom datasource argument ${var}. Aborting build."
#    exit 1
#    ;;
#  esac
#done
#PROFILES_ARG=${PROFILES_ARG%,}
#fi


echo "*******************************************************"
echo "Building ThirdEye"
echo "*******************************************************"

## Check if the dist directory exists and if so remove it before the below
## This is to handle the permission problem. Ref: https://medium.com/@gregsimons_84/apache-pinot-thirdeye-quickstart-helper-b5d8a95a22eb
if [[ -d "thirdeye-dist/target" ]]
then
    echo "Removing Target Directory"
    rm -rf thirdeye-dist/target
fi
mvn clean install -DskipTests -DTHIRDEYE_ENV=$1 || exit 1
