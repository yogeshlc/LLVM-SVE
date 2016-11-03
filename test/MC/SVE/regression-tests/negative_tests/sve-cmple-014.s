// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS8CmpFlgLEVWZ
// Restricted predicate has range [0, 7].
cmple p4.b, p8/z, z7.b, z25.d
// CHECK: error: invalid operand
