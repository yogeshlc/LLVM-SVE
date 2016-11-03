// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CntVM
// Restricted predicate has range [0, 7].
cnt z8.d, p8/m, z16.d
// CHECK: error: invalid operand
