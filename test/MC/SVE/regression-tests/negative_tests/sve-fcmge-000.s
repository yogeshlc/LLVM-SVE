// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64CmpGEV0Z
// Restricted predicate has range [0, 7].
fcmge p11.d, p8/z, z27.d, #0.0
// CHECK: error: invalid operand
