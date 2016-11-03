// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF64FromS8VM
// Restricted predicate has range [0, 7].
scvtf z17.s, p8/m, z21.d
// CHECK: error: invalid operand
