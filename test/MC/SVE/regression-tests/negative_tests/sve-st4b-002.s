// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8E4Store1SIZ
// Restricted predicate has range [0, 7].
st4b {z6.b, z7.b, z8.b, z9.b}, p8, [x11, #11, MUL VL]
// CHECK: error: invalid operand
