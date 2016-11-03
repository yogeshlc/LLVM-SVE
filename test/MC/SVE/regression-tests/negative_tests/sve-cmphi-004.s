// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CmpFlgGTVWZ
// Restricted predicate has range [0, 7].
cmphi p7.h, p8/z, z27.h, z16.d
// CHECK: error: invalid operand
