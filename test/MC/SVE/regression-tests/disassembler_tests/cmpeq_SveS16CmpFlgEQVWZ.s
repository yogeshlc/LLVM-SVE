# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xa7,0x2d,0x48,0x24
# CHECK: cmpeq   p7.h, p3/z, z13.h, z8.d // encoding: [0xa7,0x2d,0x48,0x24]
# CHECK-ERROR-NOT: cmpeq   p7.h, p3/z, z13.h, z8.d 
0xef,0x3f,0x5f,0x24
# CHECK: cmpeq   p15.h, p7/z, z31.h, z31.d // encoding: [0xef,0x3f,0x5f,0x24]
# CHECK-ERROR-NOT: cmpeq   p15.h, p7/z, z31.h, z31.d 
0x00,0x20,0x40,0x24
# CHECK: cmpeq   p0.h, p0/z, z0.h, z0.d // encoding: [0x00,0x20,0x40,0x24]
# CHECK-ERROR-NOT: cmpeq   p0.h, p0/z, z0.h, z0.d 
0x45,0x35,0x55,0x24
# CHECK: cmpeq   p5.h, p5/z, z10.h, z21.d // encoding: [0x45,0x35,0x55,0x24]
# CHECK-ERROR-NOT: cmpeq   p5.h, p5/z, z10.h, z21.d 
