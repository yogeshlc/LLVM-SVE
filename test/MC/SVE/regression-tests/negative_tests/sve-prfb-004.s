// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Prefetch1YSV
// Restricted predicate has range [0, 7].
prfb #7, p8, [x19, z12.s, uxtw]
// CHECK: error: invalid operand
