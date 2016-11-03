// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CStore2LSSZ
// Restricted predicate has range [0, 7].
st1h z18.h, p8, [x14, x24, lsl #1]
// CHECK: error: invalid operand
