// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16MaxVVM
// Restricted predicate has range [0, 7].
smax z5.h, p8/m, z5.h, z6.h
// CHECK: error: invalid operand
