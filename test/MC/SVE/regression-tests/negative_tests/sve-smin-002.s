// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve  2>&1 < %s| FileCheck %s
// VecS16MinVIX
// Source and Destination Registers must match
smin z8.h, z9.h, #-128
// CHECK: error: operand must match destination register
