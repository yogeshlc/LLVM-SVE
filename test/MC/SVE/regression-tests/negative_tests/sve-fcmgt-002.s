// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32CmpGTV0Z
// Restricted predicate has range [0, 7].
fcmgt p8.s, p8/z, z27.s, #0.0
// CHECK: error: invalid operand
