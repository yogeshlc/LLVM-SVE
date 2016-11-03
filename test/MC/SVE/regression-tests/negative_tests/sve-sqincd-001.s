// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS64QIncrVL4SI
// Immediate not compatible with encode/decode function.
sqincd x7, w7, pow2, MUL #17
// CHECK: error: immediate must be an integer in range [1, 16]
