// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8CmpFlgLTVWZ
// Restricted predicate has range [0, 7].
cmplt p0.b, p8/z, z20.b, z26.d
// CHECK: error: invalid operand
