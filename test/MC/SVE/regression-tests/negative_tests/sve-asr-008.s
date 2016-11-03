// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16ShrVWM
// Restricted predicate has range [0, 7].
asr z30.h, p8/m, z30.h, z13.d
// CHECK: error: invalid operand
