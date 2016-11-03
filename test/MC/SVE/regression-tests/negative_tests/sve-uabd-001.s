// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16AbdVVM
// Source and Destination Registers must match
uabd z8.h, p0/m, z9.h, z27.h
// CHECK: error: operand must match destination register
