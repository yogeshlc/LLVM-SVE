# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xa7,0x2d,0xd2,0x65
# CHECK: fcmeq   p7.d, p3/z, z13.d, #0.0{{0*}} // encoding: [0xa7,0x2d,0xd2,0x65]
# CHECK-ERROR-NOT: fcmeq   p7.d, p3/z, z13.d, #0.0{{0*}} 
0x45,0x35,0xd2,0x65
# CHECK: fcmeq   p5.d, p5/z, z10.d, #0.0{{0*}} // encoding: [0x45,0x35,0xd2,0x65]
# CHECK-ERROR-NOT: fcmeq   p5.d, p5/z, z10.d, #0.0{{0*}} 
0x00,0x20,0xd2,0x65
# CHECK: fcmeq   p0.d, p0/z, z0.d, #0.0{{0*}} // encoding: [0x00,0x20,0xd2,0x65]
# CHECK-ERROR-NOT: fcmeq   p0.d, p0/z, z0.d, #0.0{{0*}} 
0xef,0x3f,0xd2,0x65
# CHECK: fcmeq   p15.d, p7/z, z31.d, #0.0{{0*}} // encoding: [0xef,0x3f,0xd2,0x65]
# CHECK-ERROR-NOT: fcmeq   p15.d, p7/z, z31.d, #0.0{{0*}} 
