// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch4YSV
// Restricted predicate has range [0, 7].
prfw pldl1strm, p8, [x25, z20.d, uxtw #2]
// CHECK: error: invalid operand
