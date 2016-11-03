// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16ShrRVVM
// Restricted predicate has range [0, 7].
asrr z18.h, p8/m, z18.h, z7.h
// CHECK: error: invalid operand
