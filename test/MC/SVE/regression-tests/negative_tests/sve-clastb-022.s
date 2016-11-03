// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8VCondXBVV
// Restricted predicate has range [0, 7].
clastb z30.b, p8, z30.b, z30.b
// CHECK: error: invalid operand
