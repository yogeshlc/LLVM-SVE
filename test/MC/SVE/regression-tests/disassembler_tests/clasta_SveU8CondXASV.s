# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xbf,0x30,0x05
# CHECK: clasta  wzr, p7, wzr, z31.b // encoding: [0xff,0xbf,0x30,0x05]
# CHECK-ERROR-NOT: clasta  wzr, p7, wzr, z31.b 
0x00,0xa0,0x30,0x05
# CHECK: clasta  w0, p0, w0, z0.b // encoding: [0x00,0xa0,0x30,0x05]
# CHECK-ERROR-NOT: clasta  w0, p0, w0, z0.b 
0xb7,0xad,0x30,0x05
# CHECK: clasta  w23, p3, w23, z13.b // encoding: [0xb7,0xad,0x30,0x05]
# CHECK-ERROR-NOT: clasta  w23, p3, w23, z13.b 
0x55,0xb5,0x30,0x05
# CHECK: clasta  w21, p5, w21, z10.b // encoding: [0x55,0xb5,0x30,0x05]
# CHECK-ERROR-NOT: clasta  w21, p5, w21, z10.b 
