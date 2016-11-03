# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0xa0,0xc0,0x24
# CHECK: cmpeq   p0.d, p0/z, z0.d, z0.d // encoding: [0x00,0xa0,0xc0,0x24]
# CHECK-ERROR-NOT: cmpeq   p0.d, p0/z, z0.d, z0.d 
0x45,0xb5,0xd5,0x24
# CHECK: cmpeq   p5.d, p5/z, z10.d, z21.d // encoding: [0x45,0xb5,0xd5,0x24]
# CHECK-ERROR-NOT: cmpeq   p5.d, p5/z, z10.d, z21.d 
0xa7,0xad,0xc8,0x24
# CHECK: cmpeq   p7.d, p3/z, z13.d, z8.d // encoding: [0xa7,0xad,0xc8,0x24]
# CHECK-ERROR-NOT: cmpeq   p7.d, p3/z, z13.d, z8.d 
0xef,0xbf,0xdf,0x24
# CHECK: cmpeq   p15.d, p7/z, z31.d, z31.d // encoding: [0xef,0xbf,0xdf,0x24]
# CHECK-ERROR-NOT: cmpeq   p15.d, p7/z, z31.d, z31.d 
