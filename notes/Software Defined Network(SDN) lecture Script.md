---
tags: [lecture script, Notebooks/Network, Notebooks/Research/SDN]
title: Software Defined Network(SDN) lecture Script
created: '2020-01-16T16:32:59.019Z'
modified: '2020-02-18T14:47:08.175Z'
---

# Software Defined Network(SDN) lecture Script

[TOC]

##  HW-SW co-design for next generation Cloud Systems

[lecturer]

Xin Jin, Johns Hopkins University

[motivation]

- moore’ low vs. more demand; domain-specific processors merge
- the revolution in network: software define network(SDN), e.g. PISA switches

{key challenges}

highly-skewed and rapidly-changing workloads in cloud systems

{idea & opportunity}

- fast, small cache for load balancing
- The emergence of P4 and programmable data planes enables new use cases, some of which go beyond traditional packet-processing to application-level functionality

{research target}

IO-intensive workloads programmable switches

[relative paper]



*<u>`Netcache`: Balancing key-value stores with fast in-network caching</u>*

> Why we use Key-Value Store?

- good scalability: Key-value stores are a critical building block for <u>large-scale</u> Internet services.

> What is the problem?

1. <u>Load balancing for performance guarantees</u>

   - KV Stores are expected to provide high performance guarantees and meet strict service level agreements (SLAs).

   - Unfortunately, the skewed, dynamic nature of real-world workloads make it difficult to provide these guarantees in practice, as popular items are queried far more often than other items, leading to severe imbalances.

   ![Cache performance analysis](./Software Defined Network(SDN) lecture Script.assets/netcache-image1.png)

2. <u>Load balancing with small, fast caches</u>

   - Caching is an effective technique for addressing load imbalance.

   - Using a theoretical analysis, we could prove that the size of cache could be quiet small.

     > a cache only needs to store $O(n\log{n})$ items to balance the load for a hash-partitioned key-value cluster with N storage nodes, regardless of the number of key-value items. 

   - However, to handle skewed workloads, we would need to build a caching layer with a similar number of nodes as the storage layer, resulting in high cost(it uses too many caching nodes) and high overhead(cache layer nodes must be modified for each cache update)

3. <u>In-network caching for key-value stores</u>

   > Why do we purpose caching in network?
   >
   > - In-memory caches are effective for flash-based and disk-based key-value stores
   > - As key-value stores themselves are being moved to the main memory, in-memory caches lose their performance advantage and are no longer effective.
   > - Building the caching layer into the network is a natural solution for balancing in-memory key-value stores

   - Switches are optimized for data input-output, they offer orders of magnitude better performance compared to storage servers
   - Furthermore, if we use the ToR switch as the cache for a key-value storage rack, it incurs no latency penalties and no additional hardware costs.
   - traditional caches usually require a high cache hit ratio (>90%) to absorb most queries
   - `NetCache` uses switches primarily for load-balancing, so it provides significant benefits even with a modest cache hit ratio (<50%)
   - Specifically, `NetCache` provides high aggregate throughput and low latency, even under skewed and rapidly-changing workloads.

{System Design}

![NetCache architecture](./Software Defined Network(SDN) lecture Script.assets/netcache-image2.png)

**switch**: implementing on-path caching for KV items and routing packets

**Key-Value Cache**: Store the most frequently-accessed items; leverage match-action tables and register arrays to index, store, and serve key-value items

**Query Statistics**: Provides key-access statistics to the controller for cache update. It contains: (i)pre-key counter(ii)heavy hitter (HH) detector 

**Controller**: The controller is responsible for updating the cache with hot items.

**Storage servers**:  run a simple shim that provide two important pieces of functionality (i) mapping NetCache query packets to API calls for the key-value store (ii) implementing a cache coherence mechanism that guarantees consistency between the caching and storage layers

*<u>`DistCache`: Provable Load Balancing for Large-Scale Storage Systems with Distributed Caching</u>*

Another problem: What if we have more that one rack?

-  when the system scales out to multiple clusters, the fast cache itself would become the bottleneck. 
- Traditional mechanisms like cache partition and cache replication either result in <u>load imbalance between cache nodes</u> or <u>have high overhead for cache coherence</u>.

> Background knowledges: several load balancing methods
>
> |                      | Remark                                                       | adv. & dis.                                                  |
> | -------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
> | Round Robin          |                                                              | never consider load balancing                                |
> | Random:              | randomly select one machines                                 | never consider load balancing                                |
> | Least Connection:    | select one with least workload                               | need workload info.<br />centralization                      |
> | power-of-two-choices | random select two machines; then select the machine with less workload among these two machines | natural decentralization<br />theoretical guarantee that the maximum load of the machine is much lower than that of random |

key idea:

- Use independent hash functions to partitions hot objects in different layers

- Then use <u>power-of-two-choices</u> to select nodes with lower load access.

  ![img](./Software Defined Network(SDN) lecture Script.assets/v2-64d59c3892659a8e1518d90d621610b8_hd.jpg)

*<u>`NetChain`: Scale-Free Sub-RTT Coordination</u>*

problem: Traditional server-based solutions require multiple round-trip times (RTTs) to process a query.

key idea:

- exploits recent advances in programmable switches to store data and process queries entirely in the network data plane
- eliminates the query processing at coordination servers and cuts the end-to-end latency to as little as half of an RTT
- design new protocols and algorithms based on chain replication to guarantee strong consistency and to efficiently handle switch failures. 

[future work]

- self-driving networks
- software-defined datacenters with programmable hardware
- network support for distributed machine learning
