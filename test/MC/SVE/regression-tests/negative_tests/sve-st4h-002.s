// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16E4Store2SIZ
// Restricted predicate has range [0, 7].
st4h {z6.h, z7.h, z8.h, z9.h}, p8, [x22, #1, MUL VL]
// CHECK: error: invalid operand
