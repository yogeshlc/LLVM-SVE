// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16ShrVWM
// Source and Destination Registers must match
asr z12.h, p4/m, z13.h, z25.d
// CHECK: error: operand must match destination register
