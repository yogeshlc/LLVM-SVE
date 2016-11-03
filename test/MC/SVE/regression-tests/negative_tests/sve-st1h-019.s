// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CStore2SIZ
// Restricted predicate has range [0, 7].
st1h z16.d, p8, [x24, #13, MUL VL]
// CHECK: error: invalid operand
