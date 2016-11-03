// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16MulVVM
// Source and Destination Registers must match
mul z21.h, p6/m, z22.h, z8.h
// CHECK: error: operand must match destination register
