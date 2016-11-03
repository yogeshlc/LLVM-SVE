// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32CondXBSV
// Source and Destination Registers must match
clastb s27, p2, s28, z8.s
// CHECK: error: operand must match destination register
