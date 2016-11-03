// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CStore1LSSZ
// Restricted predicate has range [0, 7].
st1b z28.h, p8, [x24, x21]
// CHECK: error: invalid operand
