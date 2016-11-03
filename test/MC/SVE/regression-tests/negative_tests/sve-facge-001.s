// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32AcGEVVZ
// Restricted predicate has range [0, 7].
facge p10.s, p8/z, z30.s, z23.s
// CHECK: error: invalid operand
