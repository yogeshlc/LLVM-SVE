// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CmpFlgGEVVZ
// Restricted predicate has range [0, 7].
cmphs p11.b, p8/z, z0.b, z6.b
// CHECK: error: invalid operand
