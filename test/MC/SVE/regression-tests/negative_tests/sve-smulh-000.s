// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16MulHVVM
// Restricted predicate has range [0, 7].
smulh z3.h, p8/m, z3.h, z17.h
// CHECK: error: invalid operand
