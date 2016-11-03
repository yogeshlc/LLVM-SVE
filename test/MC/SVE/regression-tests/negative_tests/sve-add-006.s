// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16AddVVM
// Restricted predicate has range [0, 7].
add z21.h, p8/m, z21.h, z26.h
// CHECK: error: invalid operand
