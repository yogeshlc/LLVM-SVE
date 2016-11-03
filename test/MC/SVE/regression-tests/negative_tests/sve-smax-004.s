// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16MaxVVM
// Source and Destination Registers must match
smax z9.h, p4/m, z10.h, z19.h
// CHECK: error: operand must match destination register
