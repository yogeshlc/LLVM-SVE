// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CStore4SIZ
// Restricted predicate has range [0, 7].
st1w z10.s, p8, [x9, #14, MUL VL]
// CHECK: error: invalid operand
