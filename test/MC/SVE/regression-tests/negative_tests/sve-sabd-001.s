// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16AbdVVM
// Source and Destination Registers must match
sabd z20.h, p5/m, z21.h, z22.h
// CHECK: error: operand must match destination register
