# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x10,0xa0,0xc0,0x24
# CHECK: cmpne   p0.d, p0/z, z0.d, z0.d // encoding: [0x10,0xa0,0xc0,0x24]
# CHECK-ERROR-NOT: cmpne   p0.d, p0/z, z0.d, z0.d 
0xb7,0xad,0xc8,0x24
# CHECK: cmpne   p7.d, p3/z, z13.d, z8.d // encoding: [0xb7,0xad,0xc8,0x24]
# CHECK-ERROR-NOT: cmpne   p7.d, p3/z, z13.d, z8.d 
0x55,0xb5,0xd5,0x24
# CHECK: cmpne   p5.d, p5/z, z10.d, z21.d // encoding: [0x55,0xb5,0xd5,0x24]
# CHECK-ERROR-NOT: cmpne   p5.d, p5/z, z10.d, z21.d 
0xff,0xbf,0xdf,0x24
# CHECK: cmpne   p15.d, p7/z, z31.d, z31.d // encoding: [0xff,0xbf,0xdf,0x24]
# CHECK-ERROR-NOT: cmpne   p15.d, p7/z, z31.d, z31.d 
