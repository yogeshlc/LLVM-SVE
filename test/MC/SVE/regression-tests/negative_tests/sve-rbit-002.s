// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64RBitVM
// Restricted predicate has range [0, 7].
rbit z15.d, p8/m, z12.d
// CHECK: error: invalid operand
