// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64CLoadFF4LSSZ
// Restricted predicate has range [0, 7].
ldff1sw z23.d, p8/z, [x6, x24, lsl #2]
// CHECK: error: invalid operand
