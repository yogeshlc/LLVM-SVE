// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64CmpLEV0Z
// Restricted predicate has range [0, 7].
fcmle p0.d, p8/z, z1.d, #0.0
// CHECK: error: invalid operand
