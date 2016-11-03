// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CntVM
// Restricted predicate has range [0, 7].
cnt z2.h, p8/m, z7.h
// CHECK: error: invalid operand
