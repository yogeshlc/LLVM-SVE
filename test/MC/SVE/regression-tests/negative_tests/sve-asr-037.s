// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8ShrVWM
// Source and Destination Registers must match
asr z0.b, p4/m, z1.b, z5.d
// CHECK: error: operand must match destination register
