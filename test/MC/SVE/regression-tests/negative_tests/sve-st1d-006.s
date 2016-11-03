// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Store8VIZ
// Restricted predicate has range [0, 7].
st1d z28.d, p8, [z17.d, #19]
// CHECK: error: invalid operand
