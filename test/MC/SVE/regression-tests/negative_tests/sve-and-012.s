// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8AndVVM
// Restricted predicate has range [0, 7].
and z27.b, p8/m, z27.b, z0.b
// CHECK: error: invalid operand
