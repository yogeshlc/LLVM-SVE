SVE Enhancements to LLVM
========================

This repository is a clone of the public LLVM repository (http://llvm.org), plus
a single patch which provides support for the ARMv8-A Scalable Vector Extension
(SVE).

ARM is providing this repository to aid discussions about:
* Adding support for SVE to LLVM for SVE
* IR changes to support vectorizing loops in a scalable manner

This patch is for information purposes only. It is not intended for inclusion
into upstream LLVM. Any proposed changes to LLVM resulting from discussion
provoked by this patch will be implemented by individual patches created and
reviewed separately.

ARM provides no assurances regarding maintenance or support for this repository.
Pull requests will not be accepted.  ARM intends to remove it once the SVE and
vectorization discussion is complete.

This patch includes (but is not limited to):
* Support for scalable vector types in the IR and SelectionDAG
* New IR instructions and corresponding ISD opcodes:
  * elementcount
  * seriesvector
  * test
  * propff
* Changes to the LoopVectorize pass to use these new IR instructions to
  vectorize loops in a vector-length-agnostic manner with loop control flow
  based on predication
* Changes in multiple passes to support the new instructions and scalable types
* Changes in multiple passes to increase opportunities for vectorization
* Experimental search loop vectorization pass
* New AArch64 target passes to recognize common patterns and replace with
  intrinsics
* Tablegen modifications to support the new MVTs and provide better operand
  matching
* Instruction/register info td files and lowering code for SVE
* A provisional implementation of an SVE procedure call standard, may be changed
  in future

Contributors:
Amara Emerson
Assad Hashmi
David Sherwood
Florian Hahn
Francesco Petrogalli
Graham Hunter
Kiran Chandramohan
Maciej Gabka
Paul Walker
Richard Sandiford
Sander De Smalen
Will Lovett
