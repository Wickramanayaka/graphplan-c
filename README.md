## Graphplan Algorithm ##

<br>

This is the original work of  Avrim Blum, Merrick Furst, John Langford took it from https://www.cs.cmu.edu/~avrim/graphplan.html.

I made it work with the latest gcc (i686-w64-mingw32) compiler 

<hr>

### Run the pre-build Microsoft Windows 10/11 (32bit/64bit) binary ###

* Git clone or download the code
```
git clone https://github.com/Wickramanayaka/graphplan-c.git
```

* Using your favorite terminal (DOS or Git Bash or Powershell) change directory into graphplan-c/bin/Debug
```
$ cd graphplan-c/bin/Debug
```
* If you are using DOS (cmd.exe) command prompt, copy and paste below command line into the terminal and hit Enter key.
```
graphplan.exe -o ../../examples/aircargo/aircargo_ops -f ../../examples/aircargo/aircargo_facts -O IL -d
```
* If you are using git-bash or Powershell terminal, copy and paste below command line into the terminal and hit Enter key.
```
./graphplan.exe -o ../../examples/aircargo/aircargo_ops -f ../../examples/aircargo/aircargo_facts -O IL -d
```
<hr>

### Run the pre-build macOS Monterey (Intel chip) binary ###

* Git clone or download the code
```
git clone https://github.com/Wickramanayaka/graphplan-c.git
```

* Using <b>zsh</b> terminal change directory into graphplan-c/bin/Debug
```
% cd graphplan-c/bin/Debug
```
* Copy and paste below command line into the terminal and hit Enter key.
```
% ./graphplan -o ../../examples/aircargo/aircargo_ops -f ../../examples/aircargo/aircargo_facts -O IL -d
```

<hr>

### Build from the source - Microsoft Windows 10/11 ###

* The original code was written in 1997 and I used the following compiler provided by <a href="https://www.codeblocks.org/downloads/binaries/">Code Blocks </a> the well-known C/C++ IDE to build the application.
* Download the <a href='https://www.fosshub.com/Code-Blocks.html?dwl=codeblocks-20.03-32bit-mingw-32bit-setup.exe'>``` codeblocks-20.03-32bit-mingw-32bit-setup.exe ```</a> exact version from the link below.
```
https://www.fosshub.com/Code-Blocks.html?dwl=codeblocks-20.03-32bit-mingw-32bit-setup.exe
```
* This Code Blocks setup has mingw-32bit compiler.
* The Code Blocks installation is straight forward.
* Once the installation is done make sure to setup compiler for Code Blocks by follwing few steps bellow.
* Run Code Blocks
* Then navigate to <b> Settings -> Compiler... -> Toolchain executables</b>

<img src='./img/compiler.jpg'>

* Change followings according to your Code Blocks installation.

> Compiler's Installation Directory : ``` C:\Program Files (x86)\CodeBlocks\MinGW\bin ```

> C compiler : ``` C:\Program Files (x86)\CodeBlocks\MinGW\bin\i686-w64-mingw32-gcc.exe ```

> C++ compiler : ``` C:\Program Files (x86)\CodeBlocks\MinGW\bin\i686-w64-mingw32-g++.exe ```

> Linker for dynamic libs : ``` C:\Program Files (x86)\CodeBlocks\MinGW\bin\i686-w64-mingw32-g++.exe ```

* To open the projec click on <b>Open an existing project</b> link on the middle of Code Blocks window.
* Browse the ``` graphplan-c ``` folder (This is the folder you have cloned or downloaded and extracted previously) in your pc and select ``` graphplan.cbp ``` and open it
* Navigate to ``` Build -> Build and run ```
* Once the build process has completed the application will be loaded there you can provide *_ops and *_facts files and few more parameters to the application then the application will output the result.

<hr>

### Build from the source - macOS Monterey ###

* Using zsh terminal navigate into graphplan-c folder.
* Run below command
```
% make clean
% make
```
* The build executable file 'graphplan' will be placed in graphplan-c/bin/Debug/ folder.

<hr>

### Build from the source - Ubuntu (WSL2 - Ubuntu 20.04) ###

* Make sure you have downloaded zip or cloned repository
* Extracted to a desire location
* Using bash terminal navigate into graphplan-c folder.
* Run below command
```
% make clean
% make
```
* The build executable file 'graphplan' will be placed in graphplan-c/bin/Debug/ folder.
* You below command to install gcc if your Ubuntu distribution does not have it.
```
sudo apt update
sudo apt install build-essential
```

<hr>

### Running the examples ###
With this Github page I have added two most famous example one is <b>Air Cargo Transport World</b> (taught in MSc. Data Science and AI, University of Sri Jayewardenepura by Dr. Ananda Dehigaspitiya). The other one is <b> Rocket World </b> from the original work.

To run the each world navigate into the ``` graphplan-c\bin\Debug ``` folder using  a terminal

<br>

#### Run Air Cargo Transport ####

``` graphplan.exe -o ../../examples/aircargo/aircargo_ops -f ../../examples/aircargo/aircargo_facts -O IL -d ```

<img src="img/terminal.jpg">

Note: Make sure to add <b>' ./ '</b> if you are using git-bash or Powershell.

<br>

#### Run Rocket world ####

``` graphplan.exe -o ../../examples/rocket/rocket_ops -f ../../examples/rocket/rocket_facts -O IL -d ```

<hr>
<br>

### How to create your own world ###

<br>

Graphplan is a general-purpose planner for STRIPS-style domains, based on ideas used in graph algorithms.
To run, it will need for an "operator" file that corresponds to a domain in World, and then it will ask for a
"facts" file that corresponds to a problem in World.  

Naming convention is:

* operator files look like: domainname_ops
* facts files look like: domainname_facts

Eg:

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

<br>
<hr>
<b>DISCLAIMER</b><br>
This software is made available AS IS, and neither the me nor authors nor CMU make any warranty about the software or its performance. All the copyrights and ownerships are belongs to their respective authors.

<br> 

Visit <a href='https://www.cs.cmu.edu/~avrim/graphplan.html'>Graphplan Home Page.</a>

Visit <a href='https://www.codeblocks.org'>Code Blocks website.</a>

Visit <a href='https://www.sjp.ac.lk/'>University of Sri Jayewadenepura.</a>