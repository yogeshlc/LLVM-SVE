// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF2SVZ
// Restricted predicate has range [0, 7].
ldff1h z6.d, p8/z, [x0, z26.d, lsl #1]
// CHECK: error: invalid operand
