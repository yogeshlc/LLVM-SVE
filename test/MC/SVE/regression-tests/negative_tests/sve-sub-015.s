// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32SubVVM
// Source and Destination Registers must match
sub z8.s, p4/m, z9.s, z12.s
// CHECK: error: operand must match destination register
