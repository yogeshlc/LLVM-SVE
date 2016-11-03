// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16AbdVVM
// Restricted predicate has range [0, 7].
sabd z19.h, p8/m, z19.h, z18.h
// CHECK: error: invalid operand
