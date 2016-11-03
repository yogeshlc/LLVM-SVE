// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load4XSVZ
// Restricted predicate has range [0, 7].
ld1sw z30.d, p8/z, [x9, z14.d, sxtw #2]
// CHECK: error: invalid operand
