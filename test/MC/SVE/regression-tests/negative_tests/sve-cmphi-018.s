// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8CmpFlgGTVWZ
// Restricted predicate has range [0, 7].
cmphi p10.b, p8/z, z15.b, z0.d
// CHECK: error: invalid operand
