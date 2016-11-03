// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU8MovePrefix1VZ
// Restricted predicate has range [0, 7].
movprfx z3.b, p8/z, z9.b
// CHECK: error: invalid operand
