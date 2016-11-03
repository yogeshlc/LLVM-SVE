// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32MSUBVVVM
// Restricted predicate has range [0, 7].
msb z3.s, p8/m, z22.s, z9.s
// CHECK: error: invalid operand
