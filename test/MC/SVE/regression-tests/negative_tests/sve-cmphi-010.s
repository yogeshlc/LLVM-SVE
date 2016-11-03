// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64CmpFlgGTVIZ
// Restricted predicate has range [0, 7].
cmphi p11.d, p8/z, z6.d, #0
// CHECK: error: invalid operand
