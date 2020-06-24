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

   <img src="./routing.assets/image-20200623180705014.png" alt="image-20200623180705014" /> 

   <img src="./routing.assets/image-20200623180734100.png" alt="image-20200623180734100" /> 
  
  > Note:  With the development of modern technology, nowadays we use *channel-less routing* in industry, which means all the routing wires are on multiply layers apart from the blocks.


## Grid Routing

 <img src="./routing.assets/image-20200623181425775.png" alt="image-20200623181425775" /> 

### Maze Running Algorithm

The entire routing surface is represented by a 2D-array of grid cells.

#### Lee’s Algorithm

If a path exists between a pair of points S and T, it is definitely found.

Try to intuitively minimize the number of bends.

- strategy to reduce memory usage:

(red 0)(blue 0)(red 1)(blue 1)(red 0)……

 <img src="./routing.assets/image-20200623202330156.png" alt="image-20200623202330156" /> 

- connecting multi-point nets

   <img src="./routing.assets/image-20200623204549158.png" alt="image-20200623204549158" /> 

#### Hadlock’s Algorithm

 <img src="./routing.assets/image-20200623213237688.png" alt="image-20200623213237688" /> 

 <img src="./routing.assets/image-20200623213431850.png" alt="image-20200623213431850" /> 

The cells with least detour numbers will be expanded with high priority.

Any cell with the same detour number can be expanded simultaneously.

 <img src="./routing.assets/image-20200623213759706.png" alt="image-20200623213759706" /> 

### Linear search Algorithm

#### Mikami-Tabuchi’s Algorithm

- Step i of iteration
  - If there is no intersection, pick up trial lines of level i-1, one at a time.
    - Along the trial line, all its grid points are traced
    - starting from these grid points, new trial line of level i are generated perpendicular to the trial line of level i-1

 <img src="./routing.assets/image-20200623215309783.png" alt="image-20200623215309783" /> 

#### Hightower’s Algorithm

 <img src="./routing.assets/image-20200623215444732.png" alt="image-20200623215444732" /> 

 <img src="./routing.assets/image-20200623215712793.png" alt="image-20200623215712793" /> 

### Steiner Tree Based Algorithm

## Global Routing

 <img src="./routing.assets/image-20200624002106205.png" alt="image-20200624002106205" /> 

 <img src="./routing.assets/image-20200624002458323.png" alt="image-20200624002458323" /> 

 <img src="./routing.assets/image-20200624002442598.png" alt="image-20200624002442598" /> 

 ### Design Style Specific Issues

- <u>Standard Cell</u>. (Terminal: feed through)

   <img src="./routing.assets/image-20200624100404553.png" alt="image-20200624100404553" /> 
  
- <u>Gate Array</u>

   <img src="./routing.assets/image-20200624100509257.png" alt="image-20200624100509257" /> 

### Graph Models used in Global Routing

 <img src="./routing.assets/image-20200624100556449.png" alt="image-20200624100556449" /> 

- Checker Board Model: Not all the blockshave the same size. The edge capacities are computed based on the actual area available for routing on the cell boundary.

 <img src="./routing.assets/image-20200624101140007.png" alt="image-20200624101140007" /> 

- Channel Intersection Graph Model(channel->edge, intersection -> vertices)

   <img src="./routing.assets/image-20200624101433261.png" alt="image-20200624101433261" /> 

- Extended Channel Intersection Graph: also includes the pins as vertices

   <img src="./routing.assets/image-20200624101620316.png" alt="image-20200624101620316" /> 

### Relation with Detailed Routing

 <img src="./routing.assets/image-20200624102112894.png" alt="image-20200624102112894" /> 

### When floor-plain is Given

- The **dual graph** of floor-plan is used for global routing.

 <img src="./routing.assets/image-20200624110658162.png" alt="image-20200624110658162" /> 

 <img src="./routing.assets/image-20200624110836646.png" alt="image-20200624110836646" /> 

### When Placement is Given

The routing region is partitioned into simpler regions.

### Global Routing Algorithm: Sequential Approaches

 <img src="./routing.assets/image-20200624111303394.png" alt="image-20200624111303394" /> 

*Rip up and reroute heuristic in case of conflict.*

### Global Routing Algorithm: Integer Linear Programming Approach(only for small nets)

 <img src="./routing.assets/image-20200624113025934.png" alt="image-20200624113025934" /> 

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

   <img src="./routing.assets/image-20200624133420561.png" alt="image-20200624133420561" /> 

 <img src="./routing.assets/image-20200624120810287.png" alt="image-20200624120810287" /> 

### Order of Routing Regions

There are differences between slicing placement & non-slicing placement. In this case, some the routing regions are to be considered as switchboxes.

 <img src="./routing.assets/image-20200624121151918.png" alt="image-20200624121151918" /> 

### Models for Multi-layer Routing

 <img src="./routing.assets/image-20200624132739011.png" alt="image-20200624132739011" /> 

### Channel Routing

 <img src="./routing.assets/image-20200624133330481.png" alt="image-20200624133330481" /> 

[Problem Statement]

 <img src="./routing.assets/image-20200624133739790.png" alt="image-20200624133739790" /> 

#### Channel Constraints

 <img src="./routing.assets/image-20200624133827092.png" alt="image-20200624133827092" /> 

- Horizontal Constraint Graph(HCG)
It is a graph where vertices represent nets, and edges represent horizontal constraints.
 <img src="./routing.assets/image-20200624134006973.png" alt="image-20200624134006973" /> 
- Vertical Constraint Graph(VCG)

 <img src="./routing.assets/image-20200624134108605.png" alt="image-20200624134108605" /> 

[category of two-layer channel routing algorithm]

- constraint graph based channel router

- Greedy Channel Router

-  Hierarchical Channel Router

   <img src="./routing.assets/image-20200624154208217.png" alt="image-20200624154208217" /> 

  [category of three-layer channel routing algorithm]

   <img src="./routing.assets/image-20200624154443753.png" alt="image-20200624154443753" /> 

  

####  Left-Edge Algorithm(LEA)

 <img src="./routing.assets/image-20200624135702674.png" alt="image-20200624135702674" /> 

- terminal

  - dogleg

     <img src="./routing.assets/image-20200624135836848.png" alt="image-20200624135836848" /> 

 <img src="./routing.assets/image-20200624135957481.png" alt="image-20200624135957481" /> 

Extension to Left-Edge Algorithm: no cycle in VCG

 <img src="./routing.assets/image-20200624140256981.png" alt="image-20200624140256981" /> 

#### Dogleg Router

 <img src="./routing.assets/image-20200624143836482.png" alt="image-20200624143836482" /> 

*Note: Only use dogleg when there are three or more terminals.*

 <img src="./routing.assets/image-20200624144027552.png" alt="image-20200624144027552" /> 

 <img src="./routing.assets/image-20200624144352988.png" alt="image-20200624144352988" /> 

#### Net Merge Channel Router

 <img src="./routing.assets/image-20200624150334480.png" alt="image-20200624150334480" /> 

 <img src="./routing.assets/image-20200624150739502.png" alt="image-20200624150739502" /> 

  <img src="./routing.assets/image-20200624151536043.png" alt="image-20200624151536043" /> 

 <img src="./routing.assets/image-20200624151517171.png" alt="image-20200624151517171" /> 

 <img src="./routing.assets/image-20200624151734776.png" alt="image-20200624151734776" /> 

 <img src="./routing.assets/image-20200624152032704.png" alt="image-20200624152032704" /> 

In cases of multiple choices, merge the net-pair that minimizes the length of the longest path in VCG.

 <img src="./routing.assets/image-20200624152454144.png" alt="image-20200624152454144" /> 

 <img src="./routing.assets/image-20200624152541054.png" alt="image-20200624152541054" /> 

 <img src="./routing.assets/image-20200624152750997.png" alt="image-20200624152750997" /> 

#### Greedy Channel Router

 <img src="./routing.assets/image-20200624153349182.png" alt="image-20200624153349182" /> 

#### HVH(3-layer) from HV Solution

- terminal: track-ordering graph

 <img src="./routing.assets/image-20200624154641827.png" alt="image-20200624154641827" /> 

 <img src="./routing.assets/image-20200624154902073.png" alt="image-20200624154902073" /> 

 <img src="./routing.assets/image-20200624155015694.png" alt="image-20200624155015694" /> 

 <img src="./routing.assets/image-20200624155147684.png" alt="image-20200624155147684" /> 

Illustration:

- time -> chunk
- Leverage shortest-path algorithm to find the minimum cost of via connection

### Switchbox Routing

  <img src="./routing.assets/image-20200624155420784.png" alt="image-20200624155420784" /> 

#### Switchbox Routing: BEAVER

###  Over-the-cell(OTC) Routing

 <img src="./routing.assets/image-20200624155725942.png" alt="image-20200624155725942" /> 

- only for standard cell based design

 <img src="./routing.assets/image-20200624155909836.png" alt="image-20200624155909836" /> 

 <img src="./routing.assets/image-20200624160036427.png" alt="image-20200624160036427" /> 