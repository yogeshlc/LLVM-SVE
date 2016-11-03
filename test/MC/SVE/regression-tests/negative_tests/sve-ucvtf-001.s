// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64FromU8VM
// Restricted predicate has range [0, 7].
ucvtf z16.d, p8/m, z23.d
// CHECK: error: invalid operand
