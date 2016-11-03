// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8AndVVM
// Source and Destination Registers must match
and z21.b, p0/m, z22.b, z22.b
// CHECK: error: operand must match destination register
