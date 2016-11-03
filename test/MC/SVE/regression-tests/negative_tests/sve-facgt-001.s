// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32AcGTVVZ
// Restricted predicate has range [0, 7].
facgt p13.s, p8/z, z11.s, z20.s
// CHECK: error: invalid operand
