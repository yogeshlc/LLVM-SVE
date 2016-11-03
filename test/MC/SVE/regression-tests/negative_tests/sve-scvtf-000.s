// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64FromS4VM
// Restricted predicate has range [0, 7].
scvtf z1.d, p8/m, z6.s
// CHECK: error: invalid operand
