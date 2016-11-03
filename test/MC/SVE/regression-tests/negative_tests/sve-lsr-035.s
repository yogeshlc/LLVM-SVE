// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ShrVVM
// Source and Destination Registers must match
lsr z26.b, p5/m, z27.b, z4.b
// CHECK: error: operand must match destination register
