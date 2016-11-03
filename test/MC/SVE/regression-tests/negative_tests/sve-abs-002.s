// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64AbsVM
// Restricted predicate has range [0, 7].
abs z15.d, p8/m, z17.d
// CHECK: error: invalid operand
