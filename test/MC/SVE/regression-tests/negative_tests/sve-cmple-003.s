// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16CmpFlgLEVWZ
// Restricted predicate has range [0, 7].
cmple p10.h, p8/z, z9.h, z21.d
// CHECK: error: invalid operand
