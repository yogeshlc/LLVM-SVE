// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8ClsVM
// Restricted predicate has range [0, 7].
cls z6.b, p8/m, z15.b
// CHECK: error: invalid operand
