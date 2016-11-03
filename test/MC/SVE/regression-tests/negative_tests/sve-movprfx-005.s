// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU64MovePrefix1VZ
// Restricted predicate has range [0, 7].
movprfx z23.d, p8/z, z8.d
// CHECK: error: invalid operand
