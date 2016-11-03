// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16MinVVM
// Source and Destination Registers must match
smin z25.h, p1/m, z26.h, z14.h
// CHECK: error: operand must match destination register
