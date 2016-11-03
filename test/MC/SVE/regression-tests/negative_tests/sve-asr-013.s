// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32ShrVIM
// Source and Destination Registers must match
asr z17.s, p0/m, z18.s, #1
// CHECK: error: operand must match destination register
