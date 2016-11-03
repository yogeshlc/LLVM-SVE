// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16MADDVVVM
// Restricted predicate has range [0, 7].
mad z15.h, p8/m, z22.h, z14.h
// CHECK: error: invalid operand
