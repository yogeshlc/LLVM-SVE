// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16SubRVVM
// Source and Destination Registers must match
subr z29.h, p6/m, z30.h, z8.h
// CHECK: error: operand must match destination register
