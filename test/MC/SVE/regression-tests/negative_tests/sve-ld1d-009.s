// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load8VSZ
// Restricted predicate has range [0, 7].
ld1d z9.d, p8/z, [x4, z12.d]
// CHECK: error: invalid operand
