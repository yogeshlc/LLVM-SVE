// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16SubRVIX
// Source and Destination Registers must match
subr z20.h, z21.h, #0
// CHECK: error: operand must match destination register
