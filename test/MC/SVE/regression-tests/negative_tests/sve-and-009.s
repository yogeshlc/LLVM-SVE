// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64AndVIX
// Source and Destination Registers must match
and z12.d, z13.d, #254
// CHECK: error: operand must match destination register
