// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32MovePrefix1VM
// Restricted predicate has range [0, 7].
movprfx z21.s, p8/m, z0.s
// CHECK: error: invalid operand
