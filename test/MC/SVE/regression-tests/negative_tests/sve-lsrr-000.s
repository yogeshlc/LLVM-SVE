// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ShrRVVM
// Restricted predicate has range [0, 7].
lsrr z3.h, p8/m, z3.h, z21.h
// CHECK: error: invalid operand
