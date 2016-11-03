// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16ShrDVIM
// Source and Destination Registers must match
asrd z21.h, p2/m, z22.h, #1
// CHECK: error: operand must match destination register
