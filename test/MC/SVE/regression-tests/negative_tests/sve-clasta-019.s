// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64VCondXAVV
// Source and Destination Registers must match
clasta z25.d, p1, z26.d, z21.d
// CHECK: error: operand must match destination register
