// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch8YSV
// Restricted predicate has range [0, 7].
prfd pldl3strm, p8, [x4, z19.s, uxtw #3]
// CHECK: error: invalid operand
