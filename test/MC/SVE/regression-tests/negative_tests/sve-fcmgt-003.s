// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32CmpGTVVZ
// Restricted predicate has range [0, 7].
fcmgt p4.s, p8/z, z16.s, z29.s
// CHECK: error: invalid operand
