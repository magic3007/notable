---
tags: [markdown, Notebooks/Cheatsheet]
title: mermaid in 30 Minutes
created: '2020-02-29T11:02:31.814Z'
modified: '2020-02-29T16:34:56.192Z'
---

# mermaid in 30 Minutes

[TOC]

## Flowchart

```mermaid
graph TB
    c1-->a2
    subgraph one
    a1-->a2
    end
    subgraph two
    b1-->b2
    end
    subgraph three
    c1-->c2
    end

```

leverage <u>EntityCode</u> for special characters.

## Sequence Diagrams

```mermaid
sequenceDiagram
    participant John
    participant Alice
    Note right of Alice: Girl
    rect rgba(0, 128, 255, .1)
	%% this is a comment
	
    Alice->>+John: Hello John, how are you?
    Alice->>+John: John, can you hear me?
    Note over Alice, John: a long time
    John-->>-Alice: Hi Alice, I can hear you!
    
    end
    
    
 
    alt is sick
   	 Bob->>Alice: Not so good :(
   	else if well
   	 Bob->>Alice: Feeling fresh like a daisy
    end
    loop Every minute
    	John--xAlice: Great!
    end
    John->>-Alice: I feel great!
    opt Extra response
    Bob->>Alice: Thanks for asking
    end
    Alice ->> John: See you!
```

There are six types of arrows currently supported in sequence Diagram:

| Type | Description                                 |
| ---- | ------------------------------------------- |
| ->   | Solid line without arrow                    |
| -->  | Dotted line without arrow                   |
| ->>  | Solid line with arrowhead                   |
| -->> | Dotted line with arrowhead                  |
| -x   | Solid line with a cross at the end (async)  |
| --x  | Dotted line with a cross at the end (async) |

## Class diagrams

```mermaid
classDiagram
	 class Animal{
	      <<interface>>
		  + int age
		  + String gender
      	   + isMammal()
      	   + mate()
      	   + List~int~ position
    	   + setPoints(List~int~ points)
   		   + getPoints() List~int~
	 }

      Animal <|-- Duck
      Animal <|-- Fish
      Animal <|-- Zebra
     
      class Duck{
          +String beakColor
          +swim()
          +quack()
      }
      class Fish{
          -int sizeInFeet
          -canEat()
      }
      class Zebra{
          +bool is_wild
          +run()
      }
```

[visibility]

- `+` Public
- `-` Private
- `#` Protected
- `~` Package/Internal
- `*` Abstract e.g.: `someAbstractMethod()*`
- `$` Static e.g.: `someStaticMethod()$`

[relationship]

| Type  | Description   |
| ----- | ------------- |
| <\|-- | Inheritance   |
| *--   | Composition   |
| o--   | Aggregation   |
| -->   | Association   |
| --    | Link (Solid)  |
| ..>   | Dependency    |
| ..\|> | Realization   |
| ..    | Link (Dashed) |

```mermaid
classDiagram
classA --|> classB : Inheritance
classC --* classD : Composition
classE --o classF : Aggregation
classG --> classH : Association
classI -- classJ : Link(Solid)
classK ..> classL : Dependency
classM ..|> classN : Realization
classO .. classP : Link(Dashed)
```

## State Diagrams

```mermaid
stateDiagram
    state "This is a state description" as Still
    [*] --> Still: this is a transition description
    Still --> [*]
	
	state Moving{
		state fork_state <<fork>>
		[*] --> fork_state
		fork_state --> state2
		fork_state --> state3
		state join_state <<join>>
		state2 --> join_state
		state3 --> join_state
		join_state --> [*]
		
		--
		[*] --> state4
		[*] --> state5
		state4 --> [*]
		state5 --> [*]
	}
	Note right of Moving: You can write notes here!
    Still --> Moving
    Moving --> Still
    Moving --> Crash
    Crash --> [*]
```

## Gantt

```mermaid
gantt
       dateFormat  YYYY-MM-DD
       title Adding GANTT diagram functionality to mermaid

       section A section
       Completed task            :done,    des1, 2014-01-06,2014-01-08
       Active task               :active,  des2, 2014-01-09, 3d
       Future task               :         des3, after des2, 5d
       Future task2              :         des4, after des3, 5d

       section Critical tasks
       Completed task in the critical line :crit, done, 2014-01-06,24h
       Implement parser and jison          :crit, done, after des1, 2d
       Create tests for parser             :crit, active, 3d
       Future task in critical line        :crit, 5d
       Create tests for renderer           :2d
       Add to mermaid                      :1d

       section Documentation
       Describe gantt syntax               :active, a1, after des1, 3d
       Add gantt diagram to demo page      :after a1  , 20h
       Add another diagram to demo page    :doc1, after a1  , 48h

       section Last section
       Describe gantt syntax               :after doc1, 3d
       Add gantt diagram to demo page      :20h
       Add another diagram to demo page    :48h
```

### Time Description

```
YYYY    2014    4 digit year
YY    14    2 digit year
Q    1..4    Quarter of year. Sets month to first month in quarter.
M MM    1..12    Month number
MMM MMMM    January..Dec    Month name in locale set by moment.locale()
D DD    1..31    Day of month
Do    1st..31st    Day of month with ordinal
DDD DDDD    1..365    Day of year
X    1410715640.579    Unix timestamp
x    1410715640579    Unix ms timestamp

Input    Example    Description
H HH    0..23    24 hour time
h hh    1..12    12 hour time used with a A.
a A    am pm    Post or ante meridiem
m mm    0..59    Minutes
s ss    0..59    Seconds
S    0..9    Tenths of a second
SS    0..99    Hundreds of a second
SSS    0..999    Thousandths of a second
Z ZZ    +12:00    Offset from UTC as +-HH:mm, +-HHmm, or Z
```

More info in: http://momentjs.com/docs/#/parsing/string-format/

### Scale

```
%a - abbreviated weekday name.
%A - full weekday name.
%b - abbreviated month name.
%B - full month name.
%c - date and time, as "%a %b %e %H:%M:%S %Y".
%d - zero-padded day of the month as a decimal number [01,31].
%e - space-padded day of the month as a decimal number [ 1,31]; equivalent to %_d.
%H - hour (24-hour clock) as a decimal number [00,23].
%I - hour (12-hour clock) as a decimal number [01,12].
%j - day of the year as a decimal number [001,366].
%m - month as a decimal number [01,12].
%M - minute as a decimal number [00,59].
%L - milliseconds as a decimal number [000, 999].
%p - either AM or PM.
%S - second as a decimal number [00,61].
%U - week number of the year (Sunday as the first day of the week) as a decimal number [00,53].
%w - weekday as a decimal number [0(Sunday),6].
%W - week number of the year (Monday as the first day of the week) as a decimal number [00,53].
%x - date, as "%m/%d/%Y".
%X - time, as "%H:%M:%S".
%y - year without century as a decimal number [00,99].
%Y - year with century as a decimal number.
%Z - time zone offset, such as "-0700".
%% - a literal "%" character.
```

More info in: https://github.com/mbostock/d3/wiki/Time-Formatting

## Pie Chart

```mermaid
pie
    title Key elements in Product X
    "Calcium" : 42.96
    "Potassium" : 50.05
    "Magnesium" : 10.01
    "Iron" :  5
```



# Resources

- https://mermaidjs.github.io/#/
- https://entitycode.com/
- https://support.typora.io/Draw-Diagrams-With-Markdown/

