// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load2YVSZ
// Restricted predicate has range [0, 7].
ld1h z7.d, p8/z, [x9, z17.d, uxtw]
// CHECK: error: invalid operand
