// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64AndVVM
// Source and Destination Registers must match
and z23.d, p4/m, z24.d, z24.d
// CHECK: error: operand must match destination register
