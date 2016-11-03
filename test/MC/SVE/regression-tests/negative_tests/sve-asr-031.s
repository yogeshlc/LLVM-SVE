// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8ShrVIM
// Source and Destination Registers must match
asr z17.b, p6/m, z18.b, #1
// CHECK: error: operand must match destination register
