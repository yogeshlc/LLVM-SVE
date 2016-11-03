// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecF32ExtndHVM
// Restricted predicate has range [0, 7].
fcvt z19.s, p8/m, z5.h
// CHECK: error: invalid operand
