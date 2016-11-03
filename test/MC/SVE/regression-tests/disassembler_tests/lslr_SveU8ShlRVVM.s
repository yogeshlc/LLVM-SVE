# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x9f,0x17,0x04
# CHECK: lslr    z31.b, p7/m, z31.b, z31.b // encoding: [0xff,0x9f,0x17,0x04]
# CHECK-ERROR-NOT: lslr    z31.b, p7/m, z31.b, z31.b 
0x00,0x80,0x17,0x04
# CHECK: lslr    z0.b, p0/m, z0.b, z0.b // encoding: [0x00,0x80,0x17,0x04]
# CHECK-ERROR-NOT: lslr    z0.b, p0/m, z0.b, z0.b 
0xb7,0x8d,0x17,0x04
# CHECK: lslr    z23.b, p3/m, z23.b, z13.b // encoding: [0xb7,0x8d,0x17,0x04]
# CHECK-ERROR-NOT: lslr    z23.b, p3/m, z23.b, z13.b 
0x55,0x95,0x17,0x04
# CHECK: lslr    z21.b, p5/m, z21.b, z10.b // encoding: [0x55,0x95,0x17,0x04]
# CHECK-ERROR-NOT: lslr    z21.b, p5/m, z21.b, z10.b 
