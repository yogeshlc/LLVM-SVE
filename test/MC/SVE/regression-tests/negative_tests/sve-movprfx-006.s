// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8MovePrefix1VM
// Restricted predicate has range [0, 7].
movprfx z4.b, p8/m, z28.b
// CHECK: error: invalid operand
