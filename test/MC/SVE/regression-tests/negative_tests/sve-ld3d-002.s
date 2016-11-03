// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64E3Load8SIZ
// Restricted predicate has range [0, 7].
ld3d {z16.d, z17.d, z18.d}, p8/z, [x15, #2, MUL VL]
// CHECK: error: invalid operand
