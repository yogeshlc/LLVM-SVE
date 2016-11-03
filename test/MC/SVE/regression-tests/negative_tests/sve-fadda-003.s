// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32AddReduceAV
// Source and Destination Registers must match
fadda s27, p5, s28, z3.s
// CHECK: error: operand must match destination register
