// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32LoadFF4VIZ
// Restricted predicate has range [0, 7].
ldff1w z23.s, p8/z, [z15.s, #4]
// CHECK: error: invalid operand
