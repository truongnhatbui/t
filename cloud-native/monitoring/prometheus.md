How to scrape metrics from Prometheus
Prometheus is available as Docker image and can be configured via a YAML file.

Create a configuration file called prometheus.yml with following content:

global:
  scrape_interval: 5s
scrape_configs:
  - job_name: "example-nodejs-app"
    static_configs:
      - targets: ["docker.for.mac.host.internal:8080"]

The config file tells Prometheus to scrape all targets every 5 seconds. The targets are defined under scrape_configs. On Mac, you need to use docker.for.mac.host.internal as host, so that the Prometheus Docker container can scrape the metrics of the local Node.js HTTP server. On Windows, use docker.for.win.localhost and for Linux use localhost.

Use the docker run command to start the Prometheus Docker container and mount the configuration file (prometheus.yml):

$ docker run --rm -p 9090:9090 \
  -v `pwd`/prometheus.yml:/etc/prometheus/prometheus.yml \
  prom/prometheus:v2.20.1
Windows users need to replace pwd with the path to their current working directory.

You should now be able to access the Prometheus Web UI on http://localhost:9090