// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16RBitVM
// Restricted predicate has range [0, 7].
rbit z21.h, p8/m, z17.h
// CHECK: error: invalid operand
