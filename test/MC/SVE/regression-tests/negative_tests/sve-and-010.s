// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64AndVVM
// Restricted predicate has range [0, 7].
and z30.d, p8/m, z30.d, z20.d
// CHECK: error: invalid operand
