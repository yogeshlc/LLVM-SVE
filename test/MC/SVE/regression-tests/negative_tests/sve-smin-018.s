// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8MinVVM
// Restricted predicate has range [0, 7].
smin z8.b, p8/m, z8.b, z20.b
// CHECK: error: invalid operand
