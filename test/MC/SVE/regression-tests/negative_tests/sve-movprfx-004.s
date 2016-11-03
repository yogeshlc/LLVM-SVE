// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64MovePrefix1VM
// Restricted predicate has range [0, 7].
movprfx z10.d, p8/m, z27.d
// CHECK: error: invalid operand
