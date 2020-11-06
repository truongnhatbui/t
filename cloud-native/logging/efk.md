EFK (Elasticsearch) 

EFK Stack

You might have heard of ELK or EFK stack which has been very popular. It is a set of monitoring tools  – Elastic search (object store), Logstash or FluentD (log routing and aggregation), and  Kibana for visualization.

A typical workflow would be like the following:

Typical EFK Workflow

Elasticsearch is a real-time, distributed object storage, search and analytics engine. It excels in indexing semi-structured data such as logs. The information is serialized as JSON documents and indexed in real-time and distributed across nodes in the cluster. Elasticsearch uses an inverted index which lists all unique words and their related documents for full-text search, which is based on Apache Lucene search engine library.

FluentD is a data collector which unifies the data collection and consumption for better use. It tries to structure data as JSON as much as possible. It has plugin-architecture and supported by 100s of community provided plugins for many use-cases.

Kibana is the visualization engine for elasticsearch data, with features like time-series analysis, machine learning, graph and location analysis.

Elasticsearch Architecture
Typically in an elastic search cluster, the data stored in shards across the nodes. The cluster consists of many nodes to improve availability and resiliency. Any node is capable to perform all the roles but in a large scale deployment, nodes can be assigned specific duties.

There are following type of nodes in the cluster:

Master Nodes – controls the cluster, requires a minimum of 3, one is active at all times
Data Nodes – to hold index data and perform data-related tasks
Ingest Nodes – used for ingest pipelines to transform and enrich the data before indexing
Coordinating Nodes – to route requests, handle search reduce phase, coordinates bulk indexing
Alerting Nodes – to run alerting jobs
Machine Learning Nodes – to run machine learning jobs
Below diagram shows how the data is stored in primary and replica shards to spread the load across nodes and to improve data availability.

The data in each shard is stored in an inverted index. Below figure shows how the data would be stored in an inverted index.

source – grafana.com

EFK Stack – Quick Installation

For the detailed steps, I found a good article on DigitalOcean . Here, I am installing using helm chart in my demo.

Quickstart:

$ helm install efk-stack stable/elastic-stack --set logstash.enabled=false --set fluentd.enabled=true --set fluentd-elasticsearch.enabled=true