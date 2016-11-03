// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64_4FromDVM
// Restricted predicate has range [0, 7].
fcvtzu z10.s, p8/m, z16.d
// CHECK: error: invalid operand
