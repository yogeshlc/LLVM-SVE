# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xad,0x21,0x05
# CHECK: lastb   w23, p3, z13.b // encoding: [0xb7,0xad,0x21,0x05]
# CHECK-ERROR-NOT: lastb   w23, p3, z13.b 
0x55,0xb5,0x21,0x05
# CHECK: lastb   w21, p5, z10.b // encoding: [0x55,0xb5,0x21,0x05]
# CHECK-ERROR-NOT: lastb   w21, p5, z10.b 
0xff,0xbf,0x21,0x05
# CHECK: lastb   wzr, p7, z31.b // encoding: [0xff,0xbf,0x21,0x05]
# CHECK-ERROR-NOT: lastb   wzr, p7, z31.b 
0x00,0xa0,0x21,0x05
# CHECK: lastb   w0, p0, z0.b // encoding: [0x00,0xa0,0x21,0x05]
# CHECK-ERROR-NOT: lastb   w0, p0, z0.b 
