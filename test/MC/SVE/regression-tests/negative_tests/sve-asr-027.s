// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64ShrVVM
// Source and Destination Registers must match
asr z24.d, p2/m, z25.d, z1.d
// CHECK: error: operand must match destination register
