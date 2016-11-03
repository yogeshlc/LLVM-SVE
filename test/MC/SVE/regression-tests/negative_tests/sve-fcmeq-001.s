// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecD64CmpEQVVZ
// Restricted predicate has range [0, 7].
fcmeq p0.d, p8/z, z5.d, z22.d
// CHECK: error: invalid operand
