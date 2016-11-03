// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16MSUBVVVM
// Restricted predicate has range [0, 7].
msb z6.h, p8/m, z29.h, z2.h
// CHECK: error: invalid operand
