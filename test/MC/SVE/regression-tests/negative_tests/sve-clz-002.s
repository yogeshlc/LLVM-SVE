// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64ClzVM
// Restricted predicate has range [0, 7].
clz z10.d, p8/m, z0.d
// CHECK: error: invalid operand
