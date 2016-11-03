// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64AddVLX
// Immediate out of lower bound [-32, 31].
addvl x25, x24, #-33
// CHECK: error: index must be an integer in range [-32, 31].
