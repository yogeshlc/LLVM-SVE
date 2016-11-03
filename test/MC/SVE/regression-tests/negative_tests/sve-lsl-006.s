// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ShlVVM
// Restricted predicate has range [0, 7].
lsl z24.h, p8/m, z24.h, z14.h
// CHECK: error: invalid operand
