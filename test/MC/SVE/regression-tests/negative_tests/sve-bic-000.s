// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16BicVVM
// Restricted predicate has range [0, 7].
bic z23.h, p8/m, z23.h, z17.h
// CHECK: error: invalid operand
