// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16MulHVVM
// Restricted predicate has range [0, 7].
umulh z11.h, p8/m, z11.h, z21.h
// CHECK: error: invalid operand
