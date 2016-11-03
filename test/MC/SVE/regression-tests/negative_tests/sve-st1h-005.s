// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CStore2LSSZ
// Restricted predicate has range [0, 7].
st1h z22.s, p8, [x3, x22, lsl #1]
// CHECK: error: invalid operand
