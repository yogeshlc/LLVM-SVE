// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ShrRVVM
// Source and Destination Registers must match
lsrr z8.d, p5/m, z9.d, z28.d
// CHECK: error: operand must match destination register
