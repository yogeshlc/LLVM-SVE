// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16CmpFlgGTVIZ
// Restricted predicate has range [0, 7].
cmphi p10.h, p8/z, z1.h, #0
// CHECK: error: invalid operand
