// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32CmpGEVVZ
// Restricted predicate has range [0, 7].
fcmge p14.s, p8/z, z26.s, z8.s
// CHECK: error: invalid operand
