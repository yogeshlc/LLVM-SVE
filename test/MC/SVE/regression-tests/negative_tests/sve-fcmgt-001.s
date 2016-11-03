// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64CmpGTVVZ
// Restricted predicate has range [0, 7].
fcmgt p5.d, p8/z, z17.d, z26.d
// CHECK: error: invalid operand
