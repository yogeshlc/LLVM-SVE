// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16MulHVVM
// Source and Destination Registers must match
smulh z3.h, p0/m, z4.h, z19.h
// CHECK: error: operand must match destination register
