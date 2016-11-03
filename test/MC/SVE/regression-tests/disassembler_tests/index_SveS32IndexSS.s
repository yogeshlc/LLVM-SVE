# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x4f,0xbf,0x04
# CHECK: index   z31.s, wzr, wzr // encoding: [0xff,0x4f,0xbf,0x04]
# CHECK-ERROR-NOT: index   z31.s, wzr, wzr 
0x55,0x4d,0xb5,0x04
# CHECK: index   z21.s, w10, w21 // encoding: [0x55,0x4d,0xb5,0x04]
# CHECK-ERROR-NOT: index   z21.s, w10, w21 
0x00,0x4c,0xa0,0x04
# CHECK: index   z0.s, w0, w0 // encoding: [0x00,0x4c,0xa0,0x04]
# CHECK-ERROR-NOT: index   z0.s, w0, w0 
0xb7,0x4d,0xa8,0x04
# CHECK: index   z23.s, w13, w8 // encoding: [0xb7,0x4d,0xa8,0x04]
# CHECK-ERROR-NOT: index   z23.s, w13, w8 
