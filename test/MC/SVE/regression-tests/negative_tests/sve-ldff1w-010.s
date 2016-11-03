// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF4VIZ
// Restricted predicate has range [0, 7].
ldff1w z4.d, p8/z, [z21.d, #7]
// CHECK: error: invalid operand
