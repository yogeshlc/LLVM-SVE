// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16ShlRVVM
// Restricted predicate has range [0, 7].
lslr z26.h, p8/m, z26.h, z15.h
// CHECK: error: invalid operand
