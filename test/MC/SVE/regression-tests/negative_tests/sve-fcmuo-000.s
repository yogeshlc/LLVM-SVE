// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64CmpUNVVZ
// Restricted predicate has range [0, 7].
fcmuo p0.d, p8/z, z24.d, z22.d
// CHECK: error: invalid operand
