// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64AddVVM
// Restricted predicate has range [0, 7].
add z15.d, p8/m, z15.d, z29.d
// CHECK: error: invalid operand
