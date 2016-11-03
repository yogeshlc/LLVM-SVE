// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch2XSV
// Restricted predicate has range [0, 7].
prfh pldl1strm, p8, [x9, z21.d, sxtw #1]
// CHECK: error: invalid operand
