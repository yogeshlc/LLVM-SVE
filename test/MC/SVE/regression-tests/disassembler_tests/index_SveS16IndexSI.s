# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0x45,0x68,0x04
# CHECK: index   z23.h, w13, #8 // encoding: [0xb7,0x45,0x68,0x04]
# CHECK-ERROR-NOT: index   z23.h, w13, #8 
0x00,0x44,0x60,0x04
# CHECK: index   z0.h, w0, #0 // encoding: [0x00,0x44,0x60,0x04]
# CHECK-ERROR-NOT: index   z0.h, w0, #0 
0xff,0x47,0x7f,0x04
# CHECK: index   z31.h, wzr, #-1 // encoding: [0xff,0x47,0x7f,0x04]
# CHECK-ERROR-NOT: index   z31.h, wzr, #-1 
0x55,0x45,0x75,0x04
# CHECK: index   z21.h, w10, #-11 // encoding: [0x55,0x45,0x75,0x04]
# CHECK-ERROR-NOT: index   z21.h, w10, #-11 
