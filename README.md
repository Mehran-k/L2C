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


Documentation
=============

See `manual.pdf` for the documentation.


Publications
============

Refer to the following publications for the details of the algorithms used in this compiler:

- Seyed Mehran Kazemi and David Poole
  Knowledge Compilation for Lifted Probabilistic Inference: Compiling to a Low-Level Program
  In Proceedings of the 15th International Conference on Principles of Knowledge Representation and Reasoning, 2016
  ([pdf](http://www.cs.ubc.ca/~smkazemi/files/KazemiPoole-LRC2CPP.pdf))
- Seyed Mehran Kazemi and David Poole
  Why is Compiling Lifted Inference into a Low-Level Program so Efficient?
  In Proceedings of the Sixth International Workshop on Statistical Relational AI, 2016
  ([pdf](http://www.cs.ubc.ca/~smkazemi/files/KazemiPoole-LRC2CPP-exp.pdf))
- Seyed Mehran Kazemi and David Poole
  Elimination Ordering in Lifted First-Order Probabilistic Inference
  In Proceedings of the 28th AAAI Conference, 2014
  ([pdf](https://www.cs.ubc.ca/~poole/papers/elim-order-aaai-2014.pdf))


Contact
=======

Main contact:

Seyed Mehran Kazemi
Computer Science Department
The University of British Columbia
568-2366 Main Mall, Vancouver, BC, Canada (V6T 1Z4)  
<www.cs.ubc.ca/~smkazemi/>  
<smkazemi@cs.ubc.ca>



License
=======

Licensed under the GNU General Public License Version 3.0.
<https://www.gnu.org/licenses/gpl-3.0.en.html>


Copyright (c) 2016, The University of British Columbia. All rights reserved.