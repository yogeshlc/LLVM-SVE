// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32CmpNEVVZ
// Restricted predicate has range [0, 7].
fcmne p13.s, p8/z, z17.s, z28.s
// CHECK: error: invalid operand
