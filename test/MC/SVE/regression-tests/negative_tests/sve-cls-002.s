// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ClsVM
// Restricted predicate has range [0, 7].
cls z7.d, p8/m, z9.d
// CHECK: error: invalid operand
