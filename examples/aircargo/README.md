## Air Cargo Transport ##

This is the example used by MSc. DS & AI in University of Sri Jayewardenepura.

<hr>

Graphplan is a general-purpose planner for STRIPS-style domains, based on ideas used in graph algorithms.
To run, it will need for an "operator" file that corresponds to a domain in World, and then it will ask for a
"facts" file that corresponds to a problem in World.  

Naming convention is:

* operator files look like: aircargo_ops
* facts files look like: aircargo_facts


Our aircargo_ops file contains all the action schema in STRIP-style. If we take a look at PDDL vs STRIP it should like below.

LOAD action schema in PDDL format

```
Action(Load(c,p,a)),
     PRECOND: At(c,a) ^ At(p,a) ^ Cargo(c) ^ Plane(p) ^ Airport(a) 
     EFFECT: ~At(c,a) ^ In(c,a)
```

LOAD action schema in STRIP

```
(operator
 LOAD
 (params
  (<object> CARGO) (<plane> PLANE) (<airport> AIRPORT))
 (preconds 
  (at <plane> <airport>)  (at <object> <airport>))
 (effects 
  (in <object> <plane>) (del at <object> <airport>)))
```

UNLOAD action schema in PDDL format

```
Action(Unload(c,p,a)),
     PRECOND: In(c,p) ^ At(p,a) ^ Cargo(c) ^ Plane(p) ^ Airport(a) 
     EFFECT: At(c,a) ^ ~In(c,p)
```

UNLOAD action schema in STRIP

```
(operator
 UNLOAD
 (params
  (<object> CARGO) (<plane> PLANE) (<airport>  AIRPORT))
 (preconds 
  (at <plane> <airport>)  (in <object> <plane>))
 (effects 
  (at <object> <airport>) (del in <object> <plane>)))
```

FLY action schema in PDDL format

```
Action(Fly(p,from,to)),
     PRECOND: At(p,from) ^ Plane(p) ^ Airport(from) ^ Airport(to)) 
     EFFECT: ~At(p,from) ^ At(p,to)
```

FLY action schema in STRIP

```
(operator
 FLY
 (params
  (<plane> PLANE) (<from> AIRPORT) (<to> AIRPORT))
 (preconds 
  (at <plane> <from>))
 (effects  
  (at <plane> <to>) (del at <plane> <from>)))
```

The problem should be defined in *_facts file with initial state and goal state. Let's see how we convert PDDL into STRIP.

PDDL format

```
Init(At(C1,SFO) ^ At(C2,JFK) ^ At(P1,SFO) ^ At(P2,JFK) ^ Cargo(C1) ^ Cargo(C2) ^ Plane(P1) ^ Plane(P2) ^ Airport(JFK) ^ Airport(SFO))

Goal(At(C1,JFK) ^ At(C2,SFO))
```

STRIP-style

```
(SFO AIRPORT)
(JFK AIRPORT)
(P1 PLANE)
(P2 PLANE)
(C1 CARGO)
(C2 CARGO)

(preconds
(at P1 SFO)
(at P2 JFK)
(at C1 SFO)
(at C2 JFK))

(effects
(at C1 JFK)
(at C2 SFO))
```