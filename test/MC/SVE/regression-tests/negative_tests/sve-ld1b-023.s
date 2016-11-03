// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load1VSZ
// Restricted predicate has range [0, 7].
ld1b z14.d, p8/z, [x27, z9.d]
// CHECK: error: invalid operand
