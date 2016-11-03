// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16AndVVM
// Restricted predicate has range [0, 7].
and z14.h, p8/m, z14.h, z16.h
// CHECK: error: invalid operand
