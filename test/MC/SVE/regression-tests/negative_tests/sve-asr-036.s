// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8ShrVWM
// Restricted predicate has range [0, 7].
asr z27.b, p8/m, z27.b, z16.d
// CHECK: error: invalid operand
