// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CntVM
// Restricted predicate has range [0, 7].
cnt z11.b, p8/m, z25.b
// CHECK: error: invalid operand
