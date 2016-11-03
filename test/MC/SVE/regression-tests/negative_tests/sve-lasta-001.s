// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64LastAV
// Restricted predicate has range [0, 7].
lasta d13, p8, z4.d
// CHECK: error: invalid operand
