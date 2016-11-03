// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgGEVIZ
// Restricted predicate has range [0, 7].
cmpge p8.h, p8/z, z20.h, #-16
// CHECK: error: invalid operand
