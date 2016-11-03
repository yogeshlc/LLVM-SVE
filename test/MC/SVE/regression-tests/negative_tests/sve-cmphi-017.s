// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CmpFlgGTVVZ
// Restricted predicate has range [0, 7].
cmphi p7.b, p8/z, z5.b, z4.b
// CHECK: error: invalid operand
