// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64DivRVVM
// Source and Destination Registers must match
udivr z6.d, p5/m, z7.d, z3.d
// CHECK: error: operand must match destination register
