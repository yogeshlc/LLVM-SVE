// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8LastAV
// Restricted predicate has range [0, 7].
lasta w13, p8, z14.b
// CHECK: error: invalid operand
