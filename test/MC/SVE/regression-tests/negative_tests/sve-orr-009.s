// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64OrVIX
// Source and Destination Registers must match
orr z6.d, z7.d, #254
// CHECK: error: operand must match destination register
