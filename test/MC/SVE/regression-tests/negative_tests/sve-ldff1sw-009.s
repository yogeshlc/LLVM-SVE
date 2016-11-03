// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64LoadFF4YVSZ
// Restricted predicate has range [0, 7].
ldff1sw z23.d, p8/z, [x24, z19.d, uxtw]
// CHECK: error: invalid operand
