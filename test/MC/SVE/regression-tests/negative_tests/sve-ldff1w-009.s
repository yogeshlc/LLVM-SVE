// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64LoadFF4SVZ
// Restricted predicate has range [0, 7].
ldff1w z2.d, p8/z, [x24, z18.d, lsl #2]
// CHECK: error: invalid operand
