// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CmpFlgGTVIZ
// Restricted predicate has range [0, 7].
cmphi p6.b, p8/z, z12.b, #0
// CHECK: error: invalid operand
