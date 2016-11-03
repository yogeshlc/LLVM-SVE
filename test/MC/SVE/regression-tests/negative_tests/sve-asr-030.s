// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8ShrVIM
// Restricted predicate has range [0, 7].
asr z20.b, p8/m, z20.b, #1
// CHECK: error: invalid operand
