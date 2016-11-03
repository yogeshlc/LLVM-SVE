// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64ExtndHVM
// Restricted predicate has range [0, 7].
fcvt z29.d, p8/m, z12.h
// CHECK: error: invalid operand
