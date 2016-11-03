// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store1VIZ
// Restricted predicate has range [0, 7].
st1b z28.d, p8, [z21.d, #29]
// CHECK: error: invalid operand
