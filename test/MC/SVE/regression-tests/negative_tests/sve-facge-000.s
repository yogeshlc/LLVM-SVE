// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64AcGEVVZ
// Restricted predicate has range [0, 7].
facge p11.d, p8/z, z19.d, z9.d
// CHECK: error: invalid operand
