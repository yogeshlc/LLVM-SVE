// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32CStore1LSSZ
// Restricted predicate has range [0, 7].
st1b z2.s, p8, [x21, x29]
// CHECK: error: invalid operand
