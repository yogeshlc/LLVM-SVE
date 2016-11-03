// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64Extnd18VM
// Restricted predicate has range [0, 7].
uxtb z6.d, p8/m, z21.d
// CHECK: error: invalid operand
