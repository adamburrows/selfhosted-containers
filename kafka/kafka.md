# Kafka Demo

This demo deploys a lightweight **Apache Kafka** environment using **KRaft mode** (no ZooKeeper required) along with **Kafdrop**, a web-based UI for browsing Kafka topics, partitions, and messages.  

**Kafka (KRaft Mode)** is a single-node Kafka broker configured to use KRaft, a built-in consensus mechanism that replaces ZooKeeper, which stores both controller and broker metadata internally.  
**Kafdrop** is a lightweight web UI for Kafka that allows viewing topics, partitions, consumer groups, and inspecting individual messages directly from the browser.

---

## Run the container

```bash
podman-compose up -d
```

Open http://localhost:9000 in your web browser to create topics and view/search messages.