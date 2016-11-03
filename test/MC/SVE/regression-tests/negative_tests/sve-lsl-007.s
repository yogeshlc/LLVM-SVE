// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ShlVVM
// Source and Destination Registers must match
lsl z3.h, p5/m, z4.h, z1.h
// CHECK: error: operand must match destination register
