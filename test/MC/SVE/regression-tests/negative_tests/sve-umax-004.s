// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16MaxVVM
// Source and Destination Registers must match
umax z4.h, p4/m, z5.h, z24.h
// CHECK: error: operand must match destination register
