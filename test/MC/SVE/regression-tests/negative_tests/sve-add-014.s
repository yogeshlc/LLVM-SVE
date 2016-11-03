// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32AddVVM
// Restricted predicate has range [0, 7].
add z18.s, p8/m, z18.s, z17.s
// CHECK: error: invalid operand
