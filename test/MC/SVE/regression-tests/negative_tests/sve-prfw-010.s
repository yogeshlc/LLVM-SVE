// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Prefetch4SV
// Restricted predicate has range [0, 7].
prfw pldl2strm, p8, [x22, z0.d, lsl #2]
// CHECK: error: invalid operand
