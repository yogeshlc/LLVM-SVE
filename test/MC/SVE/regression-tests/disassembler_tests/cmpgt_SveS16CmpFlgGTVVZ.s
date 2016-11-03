# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x95,0x55,0x24
# CHECK: cmpgt   p5.h, p5/z, z10.h, z21.h // encoding: [0x55,0x95,0x55,0x24]
# CHECK-ERROR-NOT: cmpgt   p5.h, p5/z, z10.h, z21.h 
0x10,0x80,0x40,0x24
# CHECK: cmpgt   p0.h, p0/z, z0.h, z0.h // encoding: [0x10,0x80,0x40,0x24]
# CHECK-ERROR-NOT: cmpgt   p0.h, p0/z, z0.h, z0.h 
0xb7,0x8d,0x48,0x24
# CHECK: cmpgt   p7.h, p3/z, z13.h, z8.h // encoding: [0xb7,0x8d,0x48,0x24]
# CHECK-ERROR-NOT: cmpgt   p7.h, p3/z, z13.h, z8.h 
0xff,0x9f,0x5f,0x24
# CHECK: cmpgt   p15.h, p7/z, z31.h, z31.h // encoding: [0xff,0x9f,0x5f,0x24]
# CHECK-ERROR-NOT: cmpgt   p15.h, p7/z, z31.h, z31.h 
