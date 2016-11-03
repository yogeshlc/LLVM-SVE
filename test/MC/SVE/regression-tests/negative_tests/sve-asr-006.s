// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16ShrVVM
// Restricted predicate has range [0, 7].
asr z9.h, p8/m, z9.h, z21.h
// CHECK: error: invalid operand
