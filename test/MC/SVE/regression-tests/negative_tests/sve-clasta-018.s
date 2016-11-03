// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64VCondXAVV
// Restricted predicate has range [0, 7].
clasta z27.d, p8, z27.d, z13.d
// CHECK: error: invalid operand
