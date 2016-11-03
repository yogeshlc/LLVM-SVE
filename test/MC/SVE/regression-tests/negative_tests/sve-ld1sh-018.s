// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64Load2VIZ
// Restricted predicate has range [0, 7].
ld1sh z21.d, p8/z, [z19.d, #15]
// CHECK: error: invalid operand
