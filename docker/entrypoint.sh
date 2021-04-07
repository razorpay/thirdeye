#!/bin/sh
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#

app_type=$1
if [[ "${app_type}" == "frontend" ]]; then
echo "Starting TE Frontend"
sleep 15
java $JMX_CONFIG -javaagent:/opt/thirdeye/bin/jmx_prometheus_javaagent-0.13.0.jar=8080:/opt/thirdeye/config/default/jmx_config.yml -Dlog4j.configurationFile=log4j2.xml -cp "/opt/thirdeye/bin/thirdeye-dashboard-1.0.0-SNAPSHOT.jar" org.apache.pinot.thirdeye.dashboard.ThirdEyeDashboardApplication /opt/thirdeye/config/default
elif [[ "${app_type}" == "backend" ]]; then
echo "Starting TE Backend"
sleep 15
java $JMX_CONFIG -javaagent:/opt/thirdeye/bin/jmx_prometheus_javaagent-0.13.0.jar=8080:/opt/thirdeye/config/default/jmx_config.yml -Dlog4j.configurationFile=log4j2.xml -cp "/opt/thirdeye/bin/thirdeye-dashboard-1.0.0-SNAPSHOT.jar" org.apache.pinot.thirdeye.anomaly.ThirdEyeAnomalyApplication /opt/thirdeye/config/default
fi

