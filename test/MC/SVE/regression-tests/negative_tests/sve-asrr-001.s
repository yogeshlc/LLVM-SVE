// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16ShrRVVM
// Source and Destination Registers must match
asrr z10.h, p5/m, z11.h, z15.h
// CHECK: error: operand must match destination register
