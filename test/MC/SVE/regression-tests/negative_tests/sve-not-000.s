// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16InvVM
// Restricted predicate has range [0, 7].
not z24.h, p8/m, z1.h
// CHECK: error: invalid operand
