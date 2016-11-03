// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16AbsVM
// Restricted predicate has range [0, 7].
abs z8.h, p8/m, z25.h
// CHECK: error: invalid operand
