// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CondXASV
// Source and Destination Registers must match
clasta x24, p5, x25, z13.d
// CHECK: error: operand must match destination register
