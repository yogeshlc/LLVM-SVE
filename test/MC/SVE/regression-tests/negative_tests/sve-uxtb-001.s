// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32Extnd14VM
// Restricted predicate has range [0, 7].
uxtb z28.s, p8/m, z7.s
// CHECK: error: invalid operand
