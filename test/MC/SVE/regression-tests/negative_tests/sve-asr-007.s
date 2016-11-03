// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16ShrVVM
// Source and Destination Registers must match
asr z24.h, p4/m, z25.h, z1.h
// CHECK: error: operand must match destination register
