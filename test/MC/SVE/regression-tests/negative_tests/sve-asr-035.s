// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8ShrVVM
// Source and Destination Registers must match
asr z25.b, p2/m, z26.b, z16.b
// CHECK: error: operand must match destination register
