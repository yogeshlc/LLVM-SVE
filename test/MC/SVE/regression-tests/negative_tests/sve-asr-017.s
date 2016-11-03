// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32ShrVVM
// Source and Destination Registers must match
asr z15.s, p5/m, z16.s, z6.s
// CHECK: error: operand must match destination register
