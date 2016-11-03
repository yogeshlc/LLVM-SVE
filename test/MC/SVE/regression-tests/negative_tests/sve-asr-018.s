// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32ShrVWM
// Restricted predicate has range [0, 7].
asr z7.s, p8/m, z7.s, z14.d
// CHECK: error: invalid operand
