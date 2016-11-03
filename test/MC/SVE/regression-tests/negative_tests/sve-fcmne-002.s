// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32CmpNEV0Z
// Restricted predicate has range [0, 7].
fcmne p0.s, p8/z, z8.s, #0.0
// CHECK: error: invalid operand
