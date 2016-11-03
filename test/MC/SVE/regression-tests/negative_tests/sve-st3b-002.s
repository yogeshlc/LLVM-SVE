// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E3Store1SIZ
// Restricted predicate has range [0, 7].
st3b {z16.b, z17.b, z18.b}, p8, [x15, #1, MUL VL]
// CHECK: error: invalid operand
