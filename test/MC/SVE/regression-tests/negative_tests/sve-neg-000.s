// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16NegVM
// Restricted predicate has range [0, 7].
neg z28.h, p8/m, z14.h
// CHECK: error: invalid operand
