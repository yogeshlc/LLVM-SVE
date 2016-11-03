// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS32CmpFlgLTVWZ
// Restricted predicate has range [0, 7].
cmplt p10.s, p8/z, z21.s, z9.d
// CHECK: error: invalid operand
