Summary
=======

L2C compiles lifted inference or weighted first-order model counting (WFOMC) into C++ programs.


Dependencies
============
Make sure you have Ruby and g++ installed on your machine and the default Ruby version is 2.3.0 or higher.


Usage
=====

Running the L2C compiler for an input theory:

    $ ruby L2C.rb -f <filename>

For example, to find the WFOMC of example1 in the examples folder, use:

    $ ruby L2C.rb -f examples/example1.wmc

Specify the elimination ordering heuristic using `-h`. The possible values are `MNL` for MinNestedLoops and `MTS` for MinTableSize. The default heuristic is `MNL`.

If `MNL` is selected, specify the number of stochastic local search iterations using `-k`. The default value is 25.

Specify if the generated C++ programs must be readable or not using `-r`. The possible values are `true` (for readable) and `false` (for not readable). The default value is `false`. Generating readable C++ codes might be slightly slower. 

As an example, the following command runs L2C for example1 using `MNL` with 20 stochastic local search iterations and outputs readable C++ code:

    $ ruby L2C.rb -f examples/example1.wmc -h MNL -k 20 -r true


Documentation
=============

See `manual.pdf` for the documentation.


Publications
============

Refer to the following publications for the details of the algorithms used in this compiler:

- [Seyed Mehran Kazemi](http://www.cs.ubc.ca/~smkazemi) and [David Poole](http://www.cs.ubc.ca/~poole)

  [Knowledge Compilation for Lifted Probabilistic Inference: Compiling to a Low-Level Program](http://www.cs.ubc.ca/~smkazemi/files/KazemiPoole-LRC2CPP.pdf)

  In Proceedings of the 15th International Conference on Principles of Knowledge Representation and Reasoning, 2016

- [Seyed Mehran Kazemi](http://www.cs.ubc.ca/~smkazemi) and [David Poole](http://www.cs.ubc.ca/~poole)

  [Why is Compiling Lifted Inference into a Low-Level Program so Efficient?](http://www.cs.ubc.ca/~smkazemi/files/KazemiPoole-LRC2CPP-exp.pdf)

  In Proceedings of the Sixth International Workshop on Statistical Relational AI, 2016

- [Seyed Mehran Kazemi](http://www.cs.ubc.ca/~smkazemi) and [David Poole](http://www.cs.ubc.ca/~poole)

  [Elimination Ordering in Lifted First-Order Probabilistic Inference](https://www.cs.ubc.ca/~poole/papers/elim-order-aaai-2014.pdf)

  In Proceedings of the 28th AAAI Conference, 2014


Contact
=======

Seyed Mehran Kazemi

Computer Science Department

The University of British Columbia

201-2366 Main Mall, Vancouver, BC, Canada (V6T 1Z4)  

<http://www.cs.ubc.ca/~smkazemi/>  

<smkazemi@cs.ubc.ca>



License
=======

Licensed under the GNU General Public License Version 3.0.
<https://www.gnu.org/licenses/gpl-3.0.en.html>


Copyright (C) 2016  Seyed Mehran Kazemi