// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16MinVIX
// Source and Destination Registers must match
umin z22.h, z23.h, #0
// CHECK: error: operand must match destination register
