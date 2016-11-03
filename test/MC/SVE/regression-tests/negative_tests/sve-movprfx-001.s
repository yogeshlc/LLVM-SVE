// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecU16MovePrefix1VZ
// Restricted predicate has range [0, 7].
movprfx z15.h, p8/z, z25.h
// CHECK: error: invalid operand
