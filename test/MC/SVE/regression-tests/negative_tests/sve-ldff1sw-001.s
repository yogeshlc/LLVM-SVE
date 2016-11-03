// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadFF4SVZ
// Restricted predicate has range [0, 7].
ldff1sw z24.d, p8/z, [x1, z14.d, lsl #2]
// CHECK: error: invalid operand
