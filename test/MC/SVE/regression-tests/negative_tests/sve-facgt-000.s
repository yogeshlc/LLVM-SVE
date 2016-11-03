// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64AcGTVVZ
// Restricted predicate has range [0, 7].
facgt p3.d, p8/z, z16.d, z5.d
// CHECK: error: invalid operand
