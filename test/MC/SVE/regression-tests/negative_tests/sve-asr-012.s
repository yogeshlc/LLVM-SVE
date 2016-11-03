// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32ShrVIM
// Restricted predicate has range [0, 7].
asr z16.s, p8/m, z16.s, #1
// CHECK: error: invalid operand
