// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8ShrDVIM
// Source and Destination Registers must match
asrd z8.b, p2/m, z9.b, #1
// CHECK: error: operand must match destination register
