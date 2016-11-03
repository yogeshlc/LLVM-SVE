// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16OrVVM
// Source and Destination Registers must match
orr z29.h, p5/m, z30.h, z3.h
// CHECK: error: operand must match destination register
