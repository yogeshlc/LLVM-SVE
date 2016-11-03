// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32CmpEQVVZ
// Restricted predicate has range [0, 7].
fcmeq p1.s, p8/z, z7.s, z29.s
// CHECK: error: invalid operand
