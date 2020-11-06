PLG Stack (Promtail, Loki and Grafana)

Don’t be surprised if you don’t find this acronym, it is mostly known as Grafana Loki. Anyway, this stack is getting good popularity due to its opinionated design decisions. You might know about Grafana which is a popular visualization tool. Grafana labs designed Loki which is a horizontally scalable, highly available, multi-tenant log aggregation system inspired by Prometheus. It indexes only metadata and doesn’t index the content of the log. This design decision makes it very cost-effective and easy to operate.

Promtail is an agent that ships the logs from the local system to the Loki cluster. Grafana is the visualization tool which consumes data from Loki data sources.

The Loki is built on the same design principles of Prometheus, therefore it is a good fit for storing and analyzing the logs of Kubernetes.

Loki Architecture

Loki can be run in single-process mode or in multiple process mode providing independent horizontal scalability.

source: https://github.com/grafana/loki/blob/master/docs/architecture.md

Loki is designed in a way that it can be used as a single monolith or can be used as microservice. The single-process model is good for local development and small monitoring setup. For production and scalable workload, it is recommended to go with the microservices model. The write path and read path in Loki are decoupled so it is highly tuneable and can be scaled independently based on the need.

Let’s look into its logging architecture at high level with below diagram.

source: grafana.com

Below is the breakdown of the Loki (Microservice model).

Source: grafana.com

Components:

Promtail – This is the agent which is installed on the nodes (as Daemonset), it pulls the logs from the jobs and talks to Kubernetes API server to get the metadata and use this information to tag the logs. Then it forwards the log to Loki central service.  The agents support the same labelling rules as Prometheus to make sure the metadata matches.

Distributor – Promtail sends logs to the distributor which acts as a buffer. To handle millions of writes, it batches the inflow and compresses it in chunks as they come in. There are multiple ingesters, the logs belonging to each stream would end up in the same ingester for all relevant entries in the same chunk. This is done using the ring of ingesters and consistent hashing. To provide resiliency and redundancy, it does n (default 3) times.

Ingester – As the chunks come in, they are gzipped and appended with logs. Once the chunk fills up, the chunk is flushed to the database.  The metadata goes into Index and log chunk data goes into Chunks (usually an Object store).  After flushing, ingester creates a new chunk and add new entries in to that.

source: grafana.com

Index – Index is the database like DynamoDB, Cassandra, Google Bigtable, etc.

Chunks –  Chunk of logs in a compressed format is stored in the object stores like S3

Querier – This is in the read path and does all the heavy lifting. Given the time range and label selector, it looks at the index to figure out which are the matching chunks. Then it reads through those chunks and greps for the result.

Now let’s see it in action.

To install in Kubernetes, the easiest way is to use helm.  Assuming that you have helm installed and configured.

Add the Loki chart repository and install the Loki stack.

$ helm repo add loki https://grafana.github.io/loki/charts
$ helm repo update
$ helm upgrade --install loki loki/loki-stack --set grafana.enabled=true,prometheus.enabled=true,prometheus.alertmanager.persistentVolume.enabled=false,prometheus.server.persistentVolume.enabled=false
Below is a sample dashboard showing the data from Prometheus for ETCD metrics and Loki for ETCD pod logs.
Now we have discussed the architecture of both logging technologies, let’s see how they compare against each other.