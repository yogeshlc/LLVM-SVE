// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16VCondXBVV
// Restricted predicate has range [0, 7].
clastb z7.h, p8, z7.h, z5.h
// CHECK: error: invalid operand
