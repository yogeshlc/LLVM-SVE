// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CmpFlgLTVIZ
// Restricted predicate has range [0, 7].
cmplo p3.d, p8/z, z29.d, #0
// CHECK: error: invalid operand
