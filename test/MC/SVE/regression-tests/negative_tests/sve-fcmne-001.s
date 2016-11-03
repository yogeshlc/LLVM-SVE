// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64CmpNEVVZ
// Restricted predicate has range [0, 7].
fcmne p1.d, p8/z, z25.d, z3.d
// CHECK: error: invalid operand
