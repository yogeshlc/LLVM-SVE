// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU32MovePrefix1VZ
// Restricted predicate has range [0, 7].
movprfx z14.s, p8/z, z19.s
// CHECK: error: invalid operand
