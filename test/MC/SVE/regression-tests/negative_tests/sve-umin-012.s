// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64MinVIX
// Source and Destination Registers must match
umin z21.d, z22.d, #0
// CHECK: error: operand must match destination register
