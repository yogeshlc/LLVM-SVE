// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16ShrVIM
// Source and Destination Registers must match
asr z8.h, p3/m, z9.h, #1
// CHECK: error: operand must match destination register
