// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8AddVVM
// Restricted predicate has range [0, 7].
add z20.b, p8/m, z20.b, z5.b
// CHECK: error: invalid operand
