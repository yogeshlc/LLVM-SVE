// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64InvVM
// Restricted predicate has range [0, 7].
not z7.d, p8/m, z15.d
// CHECK: error: invalid operand
