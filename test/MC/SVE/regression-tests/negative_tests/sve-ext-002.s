// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8SlideVI
// Source and Destination Registers must match
ext z16.b, z17.b, z21.b, #0
// CHECK: error: operand must match destination register
