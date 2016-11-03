// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CStore1LSSZ
// Restricted predicate has range [0, 7].
st1b z17.b, p8, [x29, x17]
// CHECK: error: invalid operand
