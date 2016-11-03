// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load4YSVZ
// Restricted predicate has range [0, 7].
ld1sw z7.d, p8/z, [x25, z15.d, uxtw #2]
// CHECK: error: invalid operand
