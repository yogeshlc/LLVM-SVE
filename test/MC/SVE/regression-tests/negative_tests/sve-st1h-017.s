// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CStore2LSSZ
// Restricted predicate has range [0, 7].
st1h z18.d, p8, [x6, x7, lsl #1]
// CHECK: error: invalid operand
