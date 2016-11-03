// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64FromS8VM
// Restricted predicate has range [0, 7].
scvtf z24.d, p8/m, z26.d
// CHECK: error: invalid operand
