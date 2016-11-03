// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16VCondXAVV
// Source and Destination Registers must match
clasta z23.h, p4, z24.h, z19.h
// CHECK: error: operand must match destination register
