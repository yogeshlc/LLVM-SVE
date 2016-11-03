// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64VCondXBVV
// Restricted predicate has range [0, 7].
clastb z16.d, p8, z16.d, z30.d
// CHECK: error: invalid operand
