# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x45,0xa8,0x04
# CHECK: index   z23.s, w13, #8 // encoding: [0xb7,0x45,0xa8,0x04]
# CHECK-ERROR-NOT: index   z23.s, w13, #8 
0x55,0x45,0xb5,0x04
# CHECK: index   z21.s, w10, #-11 // encoding: [0x55,0x45,0xb5,0x04]
# CHECK-ERROR-NOT: index   z21.s, w10, #-11 
0x00,0x44,0xa0,0x04
# CHECK: index   z0.s, w0, #0 // encoding: [0x00,0x44,0xa0,0x04]
# CHECK-ERROR-NOT: index   z0.s, w0, #0 
0xff,0x47,0xbf,0x04
# CHECK: index   z31.s, wzr, #-1 // encoding: [0xff,0x47,0xbf,0x04]
# CHECK-ERROR-NOT: index   z31.s, wzr, #-1 
