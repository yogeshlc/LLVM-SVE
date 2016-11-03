// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CStore8SIZ
// Restricted predicate has range [0, 7].
st1d z29.d, p8, [x8, #13, MUL VL]
// CHECK: error: invalid operand
