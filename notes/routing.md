---
tags: [EDA]
title: routing
created: '2020-06-23T09:56:49.551Z'
modified: '2020-06-23T09:57:02.596Z'
---

# routing

## Resources

- https://www.youtube.com/channel/UCTSQnoUHhScO2ceUfqRHaKw/videos

## Overview

There are three different types of routing. Given a set of blocks placed on a layout surface and defined pin locations

- *grid routing*: given a set of obstacles and a set of pin to connect, determine a solution to interconnect the pins on a single layer

- *global routing*: determine the approximate regions through which each interconnection net should pass

- *detailed routing*: For each routing region, complete the interconnection be assigning horizonal and vertical metal line segments on the layout surface.

  ![image-20200623180705014](./routing.assets/image-20200623180705014.png)

  ![image-20200623180734100](./routing.assets/image-20200623180734100.png)
  
  > Note:  With the development of modern technology, nowadays we use *channel-less routing* in industry, which means all the routing wires are on multiply layers apart from the blocks.


## Grid Routing

![image-20200623181425775](./routing.assets/image-20200623181425775.png)

### Maze Running Algorithm

The entire routing surface is represented by a 2D-array of grid cells.

#### Lee’s Algorithm

If a path exists between a pair of points S and T, it is definitely found.

Try to intuitively minimize the number of bends.

- strategy to reduce memory usage:

(red 0)(blue 0)(red 1)(blue 1)(red 0)……

![image-20200623202330156](./routing.assets/image-20200623202330156.png)

- connecting multi-point nets

  ![image-20200623204549158](./routing.assets/image-20200623204549158.png)

#### Hadlock’s Algorithm

![image-20200623213237688](./routing.assets/image-20200623213237688.png)

![image-20200623213431850](./routing.assets/image-20200623213431850.png)

The cells with least detour numbers will be expanded with high priority.

Any cell with the same detour number can be expanded simultaneously.

![image-20200623213759706](./routing.assets/image-20200623213759706.png)

### Linear search Algorithm

#### Mikami-Tabuchi’s Algorithm

- Step i of iteration
  - If there is no intersection, pick up trial lines of level i-1, one at a time.
    - Along the trial line, all its grid points are traced
    - starting from these grid points, new trial line of level i are generated perpendicular to the trial line of level i-1

![image-20200623215309783](./routing.assets/image-20200623215309783.png)

#### Hightower’s Algorithm

![image-20200623215444732](./routing.assets/image-20200623215444732.png)

![image-20200623215712793](./routing.assets/image-20200623215712793.png)

### Steiner Tree Based Algorithm

## Global Routing

![image-20200624002106205](./routing.assets/image-20200624002106205.png)

![image-20200624002458323](./routing.assets/image-20200624002458323.png)

![image-20200624002442598](./routing.assets/image-20200624002442598.png)

 ### Design Style Specific Issues

- <u>Standard Cell</u>. (Terminal: feed through)

  ![image-20200624100404553](./routing.assets/image-20200624100404553.png)
  
- <u>Gate Array</u>

  ![image-20200624100509257](./routing.assets/image-20200624100509257.png)

### Graph Models used in Global Routing

![image-20200624100556449](./routing.assets/image-20200624100556449.png)

- Checker Board Model: Not all the blockshave the same size. The edge capacities are computed based on the actual area available for routing on the cell boundary.

![image-20200624101140007](./routing.assets/image-20200624101140007.png)

- Channel Intersection Graph Model(channel->edge, intersection -> vertices)

  ![image-20200624101433261](./routing.assets/image-20200624101433261.png)

- Extended Channel Intersection Graph: also includes the pins as vertices

  ![image-20200624101620316](./routing.assets/image-20200624101620316.png)

### Relation with Detailed Routing

![image-20200624102112894](./routing.assets/image-20200624102112894.png)

### When floor-plain is Given

- The **dual graph** of floor-plan is used for global routing.

![image-20200624110658162](./routing.assets/image-20200624110658162.png)

![image-20200624110836646](./routing.assets/image-20200624110836646.png)

### When Placement is Given

The routing region is partitioned into simpler regions.

### Global Routing Algorithm: Sequential Approaches

![image-20200624111303394](./routing.assets/image-20200624111303394.png)

*Rip up and reroute heuristic in case of conflict.*

### Global Routing Algorithm: Integer Linear Programming Approach(only for small nets)

![image-20200624113025934](./routing.assets/image-20200624113025934.png)

constraints:

- one net, many candidate solutions(mutual exclusion)
- capacity of each routing region must not be exceeded.
- if each solution is assigned a cost, a possible objective function to minimize could be defined.

### Global Routing Algorithm: Hierarchical Approaches

- divide an conquer -> integer programming problem

- two categories: top-down & bottom-up

### Global Routing Algorithm: Performance Driven Routing

## Detailed Routing

- terminal: 

  - floating terminal: virtual terminal on the boundary of the routing sub-regions. 
  - via connection: metal connection between different layers
  - channel & switchboxes

  ![image-20200624133420561](./routing.assets/image-20200624133420561.png)

![image-20200624120810287](./routing.assets/image-20200624120810287.png)

### Order of Routing Regions

There are differences between slicing placement & non-slicing placement. In this case, some the routing regions are to be considered as switchboxes.

![image-20200624121151918](./routing.assets/image-20200624121151918.png)

### Models for Multi-layer Routing

![image-20200624132739011](routing.assets/image-20200624132739011.png)

### Channel Routing

![image-20200624133330481](./routing.assets/image-20200624133330481.png)

[Problem Statement]

![image-20200624133739790](./routing.assets/image-20200624133739790.png)

#### Channel Constraints

![image-20200624133827092](./routing.assets/image-20200624133827092.png)

- Horizontal Constraint Graph(HCG)
It is a graph where vertices represent nets, and edges represent horizontal constraints.
![image-20200624134006973](./routing.assets/image-20200624134006973.png)
- Vertical Constraint Graph(VCG)

![image-20200624134108605](./routing.assets/image-20200624134108605.png)

[category of two-layer channel routing algorithm]

- constraint graph based channel router

- Greedy Channel Router

-  Hierarchical Channel Router

  ![image-20200624154208217](./routing.assets/image-20200624154208217.png)

  [category of three-layer channel routing algorithm]

  ![image-20200624154443753](./routing.assets/image-20200624154443753.png)

  

####  Left-Edge Algorithm(LEA)

![image-20200624135702674](./routing.assets/image-20200624135702674.png)

- terminal

  - dogleg

    ![image-20200624135836848](./routing.assets/image-20200624135836848.png)

![image-20200624135957481](./routing.assets/image-20200624135957481.png)

Extension to Left-Edge Algorithm: no cycle in VCG

![image-20200624140256981](./routing.assets/image-20200624140256981.png)

#### Dogleg Router

![image-20200624143836482](./routing.assets/image-20200624143836482.png)

*Note: Only use dogleg when there are three or more terminals.*

![image-20200624144027552](./routing.assets/image-20200624144027552.png)

![image-20200624144352988](./routing.assets/image-20200624144352988.png)

#### Net Merge Channel Router

![image-20200624150334480](./routing.assets/image-20200624150334480.png)

![image-20200624150739502](./routing.assets/image-20200624150739502.png)

 ![image-20200624151536043](./routing.assets/image-20200624151536043.png)

![image-20200624151517171](./routing.assets/image-20200624151517171.png)

![image-20200624151734776](./routing.assets/image-20200624151734776.png)

![image-20200624152032704](./routing.assets/image-20200624152032704.png)

In cases of multiple choices, merge the net-pair that minimizes the length of the longest path in VCG.

![image-20200624152454144](./routing.assets/image-20200624152454144.png)

![image-20200624152541054](./routing.assets/image-20200624152541054.png)

![image-20200624152750997](./routing.assets/image-20200624152750997.png)

#### Greedy Channel Router

![image-20200624153349182](./routing.assets/image-20200624153349182.png)

#### HVH(3-layer) from HV Solution

- terminal: track-ordering graph

![image-20200624154641827](./routing.assets/image-20200624154641827.png)

![image-20200624154902073](./routing.assets/image-20200624154902073.png)

![image-20200624155015694](./routing.assets/image-20200624155015694.png)

![image-20200624155147684](routing.assets/image-20200624155147684.png)

Illustration:

- time -> chunk
- Leverage shortest-path algorithm to find the minimum cost of via connection

### Switchbox Routing

 ![image-20200624155420784](./routing.assets/image-20200624155420784.png)

#### Switchbox Routing: BEAVER

###  Over-the-cell(OTC) Routing

![image-20200624155725942](./routing.assets/image-20200624155725942.png)

- only for standard cell based design

![image-20200624155909836](./routing.assets/image-20200624155909836.png)

![image-20200624160036427](./routing.assets/image-20200624160036427.png)