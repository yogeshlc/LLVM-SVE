# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xa7,0x0d,0x48,0x25
# CHECK: cmpge   p7.h, p3/z, z13.h, #8 // encoding: [0xa7,0x0d,0x48,0x25]
# CHECK-ERROR-NOT: cmpge   p7.h, p3/z, z13.h, #8 
0x45,0x15,0x55,0x25
# CHECK: cmpge   p5.h, p5/z, z10.h, #-11 // encoding: [0x45,0x15,0x55,0x25]
# CHECK-ERROR-NOT: cmpge   p5.h, p5/z, z10.h, #-11 
0x00,0x00,0x40,0x25
# CHECK: cmpge   p0.h, p0/z, z0.h, #0 // encoding: [0x00,0x00,0x40,0x25]
# CHECK-ERROR-NOT: cmpge   p0.h, p0/z, z0.h, #0 
0xef,0x1f,0x5f,0x25
# CHECK: cmpge   p15.h, p7/z, z31.h, #-1 // encoding: [0xef,0x1f,0x5f,0x25]
# CHECK-ERROR-NOT: cmpge   p15.h, p7/z, z31.h, #-1 
