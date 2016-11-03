// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64ShrVVM
// Restricted predicate has range [0, 7].
asr z26.d, p8/m, z26.d, z2.d
// CHECK: error: invalid operand
