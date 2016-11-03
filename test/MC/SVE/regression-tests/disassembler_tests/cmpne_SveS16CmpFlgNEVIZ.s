# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x8d,0x48,0x25
# CHECK: cmpne   p7.h, p3/z, z13.h, #8 // encoding: [0xb7,0x8d,0x48,0x25]
# CHECK-ERROR-NOT: cmpne   p7.h, p3/z, z13.h, #8 
0x10,0x80,0x40,0x25
# CHECK: cmpne   p0.h, p0/z, z0.h, #0 // encoding: [0x10,0x80,0x40,0x25]
# CHECK-ERROR-NOT: cmpne   p0.h, p0/z, z0.h, #0 
0xff,0x9f,0x5f,0x25
# CHECK: cmpne   p15.h, p7/z, z31.h, #-1 // encoding: [0xff,0x9f,0x5f,0x25]
# CHECK-ERROR-NOT: cmpne   p15.h, p7/z, z31.h, #-1 
0x55,0x95,0x55,0x25
# CHECK: cmpne   p5.h, p5/z, z10.h, #-11 // encoding: [0x55,0x95,0x55,0x25]
# CHECK-ERROR-NOT: cmpne   p5.h, p5/z, z10.h, #-11 
