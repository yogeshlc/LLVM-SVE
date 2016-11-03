// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Load1VIZ
// Restricted predicate has range [0, 7].
ld1b z0.d, p8/z, [z19.d, #0]
// CHECK: error: invalid operand
