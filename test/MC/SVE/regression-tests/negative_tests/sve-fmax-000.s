// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64MaxVIM
// Restricted predicate has range [0, 7].
fmax z17.d, p8/m, z17.d, #0.0
// CHECK: error: invalid operand
