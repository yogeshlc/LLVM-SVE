# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0xbf,0xb0,0x05
# CHECK: clasta  wzr, p7, wzr, z31.s // encoding: [0xff,0xbf,0xb0,0x05]
# CHECK-ERROR-NOT: clasta  wzr, p7, wzr, z31.s 
0x55,0xb5,0xb0,0x05
# CHECK: clasta  w21, p5, w21, z10.s // encoding: [0x55,0xb5,0xb0,0x05]
# CHECK-ERROR-NOT: clasta  w21, p5, w21, z10.s 
0xb7,0xad,0xb0,0x05
# CHECK: clasta  w23, p3, w23, z13.s // encoding: [0xb7,0xad,0xb0,0x05]
# CHECK-ERROR-NOT: clasta  w23, p3, w23, z13.s 
0x00,0xa0,0xb0,0x05
# CHECK: clasta  w0, p0, w0, z0.s // encoding: [0x00,0xa0,0xb0,0x05]
# CHECK-ERROR-NOT: clasta  w0, p0, w0, z0.s 
