// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load2SVZ
// Restricted predicate has range [0, 7].
ld1h z30.d, p8/z, [x11, z14.d, lsl #1]
// CHECK: error: invalid operand
