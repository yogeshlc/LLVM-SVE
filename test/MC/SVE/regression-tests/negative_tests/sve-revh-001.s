// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Rev2V
// Restricted predicate has range [0, 7].
revh z0.d, p8/m, z24.d
// CHECK: error: invalid operand
