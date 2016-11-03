// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CStore4SIZ
// Restricted predicate has range [0, 7].
st1w z12.d, p8, [x3, #5, MUL VL]
// CHECK: error: invalid operand
