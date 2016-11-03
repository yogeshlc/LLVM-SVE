// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8AbdVVM
// Source and Destination Registers must match
uabd z13.b, p1/m, z14.b, z7.b
// CHECK: error: operand must match destination register
