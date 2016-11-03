// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8SubVVM
// Source and Destination Registers must match
sub z8.b, p4/m, z9.b, z22.b
// CHECK: error: operand must match destination register
