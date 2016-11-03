// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64CmpGTV0Z
// Restricted predicate has range [0, 7].
fcmgt p8.d, p8/z, z19.d, #0.0
// CHECK: error: invalid operand
