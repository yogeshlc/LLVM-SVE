// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64CmpGEVVZ
// Restricted predicate has range [0, 7].
fcmge p2.d, p8/z, z13.d, z11.d
// CHECK: error: invalid operand
