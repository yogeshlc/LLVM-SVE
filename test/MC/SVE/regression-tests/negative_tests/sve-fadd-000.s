// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64AddVIM
// Restricted predicate has range [0, 7].
fadd z6.d, p8/m, z6.d, #0.5
// CHECK: error: invalid operand
