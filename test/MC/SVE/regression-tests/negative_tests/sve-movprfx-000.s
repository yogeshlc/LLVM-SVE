// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16MovePrefix1VM
// Restricted predicate has range [0, 7].
movprfx z0.h, p8/m, z20.h
// CHECK: error: invalid operand
