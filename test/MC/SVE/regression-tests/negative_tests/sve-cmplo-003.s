// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CmpFlgLTVWZ
// Restricted predicate has range [0, 7].
cmplo p12.h, p8/z, z18.h, z5.d
// CHECK: error: invalid operand
