// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16Rev1V
// Restricted predicate has range [0, 7].
revb z15.h, p8/m, z28.h
// CHECK: error: invalid operand
