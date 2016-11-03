// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E3Load1SIZ
// Restricted predicate has range [0, 7].
ld3b {z15.b, z16.b, z17.b}, p8/z, [x17, #12, MUL VL]
// CHECK: error: invalid operand
