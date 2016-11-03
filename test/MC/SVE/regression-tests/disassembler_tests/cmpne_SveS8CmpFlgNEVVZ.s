# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0xb5,0x15,0x24
# CHECK: cmpne   p5.b, p5/z, z10.b, z21.b // encoding: [0x55,0xb5,0x15,0x24]
# CHECK-ERROR-NOT: cmpne   p5.b, p5/z, z10.b, z21.b 
0xff,0xbf,0x1f,0x24
# CHECK: cmpne   p15.b, p7/z, z31.b, z31.b // encoding: [0xff,0xbf,0x1f,0x24]
# CHECK-ERROR-NOT: cmpne   p15.b, p7/z, z31.b, z31.b 
0xb7,0xad,0x08,0x24
# CHECK: cmpne   p7.b, p3/z, z13.b, z8.b // encoding: [0xb7,0xad,0x08,0x24]
# CHECK-ERROR-NOT: cmpne   p7.b, p3/z, z13.b, z8.b 
0x10,0xa0,0x00,0x24
# CHECK: cmpne   p0.b, p0/z, z0.b, z0.b // encoding: [0x10,0xa0,0x00,0x24]
# CHECK-ERROR-NOT: cmpne   p0.b, p0/z, z0.b, z0.b 
