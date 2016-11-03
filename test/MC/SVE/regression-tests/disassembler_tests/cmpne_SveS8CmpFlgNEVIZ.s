# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x95,0x15,0x25
# CHECK: cmpne   p5.b, p5/z, z10.b, #-11 // encoding: [0x55,0x95,0x15,0x25]
# CHECK-ERROR-NOT: cmpne   p5.b, p5/z, z10.b, #-11 
0x10,0x80,0x00,0x25
# CHECK: cmpne   p0.b, p0/z, z0.b, #0 // encoding: [0x10,0x80,0x00,0x25]
# CHECK-ERROR-NOT: cmpne   p0.b, p0/z, z0.b, #0 
0xb7,0x8d,0x08,0x25
# CHECK: cmpne   p7.b, p3/z, z13.b, #8 // encoding: [0xb7,0x8d,0x08,0x25]
# CHECK-ERROR-NOT: cmpne   p7.b, p3/z, z13.b, #8 
0xff,0x9f,0x1f,0x25
# CHECK: cmpne   p15.b, p7/z, z31.b, #-1 // encoding: [0xff,0x9f,0x1f,0x25]
# CHECK-ERROR-NOT: cmpne   p15.b, p7/z, z31.b, #-1 
