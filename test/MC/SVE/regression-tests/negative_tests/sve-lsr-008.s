// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ShrVWM
// Restricted predicate has range [0, 7].
lsr z4.h, p8/m, z4.h, z9.d
// CHECK: error: invalid operand
