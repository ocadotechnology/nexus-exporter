# nexus-exporter

Basic prometheus metrics exporter for Sonatype Nexus > v3.6

The default user is `admin`, but to collect these metrics only the `nx-metrics-all` and `nx-atlas-all` privileges are required. 

## Docker image usage

Example with the default values:
```
docker run [OTHER-DOCKER-RUN-OPTIONS] -p 9184:9184 -e NEXUS_HOST=http://localhost:8081 -e NEXUS_USERNAME=admin -e NEXUS_ADMIN_PASSWORD=admin123  ocadotechnology/nexus-exporter 
```

## Notes

nexus v3 metrics from http://[your-nexus-url]/service/metrics/data?pretty=true while logged in with the right privileges.

more stats at http://[your-nexus-url]/service/rest/atlas/system-information


## License

   Copyright 2018 Ocado

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.


