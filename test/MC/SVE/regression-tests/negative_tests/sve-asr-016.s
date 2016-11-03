// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32ShrVVM
// Restricted predicate has range [0, 7].
asr z9.s, p8/m, z9.s, z19.s
// CHECK: error: invalid operand
