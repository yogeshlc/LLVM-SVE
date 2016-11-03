// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Extnd48VM
// Restricted predicate has range [0, 7].
sxtw z5.d, p8/m, z16.d
// CHECK: error: invalid operand
