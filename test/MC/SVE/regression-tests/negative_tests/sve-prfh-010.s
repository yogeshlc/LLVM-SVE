// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch2SV
// Restricted predicate has range [0, 7].
prfh pldl3strm, p8, [x18, z0.d, lsl #1]
// CHECK: error: invalid operand
