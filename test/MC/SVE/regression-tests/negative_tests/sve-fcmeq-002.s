// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32CmpEQV0Z
// Restricted predicate has range [0, 7].
fcmeq p1.s, p8/z, z29.s, #0.0
// CHECK: error: invalid operand
