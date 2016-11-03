// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64_8FromFVM
// Restricted predicate has range [0, 7].
fcvtzu z10.d, p8/m, z28.s
// CHECK: error: invalid operand
