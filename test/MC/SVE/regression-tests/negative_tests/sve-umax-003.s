// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16MaxVVM
// Restricted predicate has range [0, 7].
umax z22.h, p8/m, z22.h, z20.h
// CHECK: error: invalid operand
