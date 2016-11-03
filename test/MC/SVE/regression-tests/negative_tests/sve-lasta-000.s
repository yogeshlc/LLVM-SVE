// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecB8LastAV
// Restricted predicate has range [0, 7].
lasta b5, p8, z23.b
// CHECK: error: invalid operand
