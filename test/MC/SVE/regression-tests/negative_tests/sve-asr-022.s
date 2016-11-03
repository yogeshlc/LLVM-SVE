// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64ShrVIM
// Restricted predicate has range [0, 7].
asr z23.d, p8/m, z23.d, #1
// CHECK: error: invalid operand
