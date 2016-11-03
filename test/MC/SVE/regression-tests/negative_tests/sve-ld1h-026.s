// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load2VSZ
// Restricted predicate has range [0, 7].
ld1h z22.d, p8/z, [x5, z3.d]
// CHECK: error: invalid operand
