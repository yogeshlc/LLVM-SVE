# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x00,0x48,0x20,0x04
# CHECK: index   z0.b, #0, w0 // encoding: [0x00,0x48,0x20,0x04]
# CHECK-ERROR-NOT: index   z0.b, #0, w0 
0x55,0x49,0x35,0x04
# CHECK: index   z21.b, #10, w21 // encoding: [0x55,0x49,0x35,0x04]
# CHECK-ERROR-NOT: index   z21.b, #10, w21 
0xff,0x4b,0x3f,0x04
# CHECK: index   z31.b, #-1, wzr // encoding: [0xff,0x4b,0x3f,0x04]
# CHECK-ERROR-NOT: index   z31.b, #-1, wzr 
0xb7,0x49,0x28,0x04
# CHECK: index   z23.b, #13, w8 // encoding: [0xb7,0x49,0x28,0x04]
# CHECK-ERROR-NOT: index   z23.b, #13, w8 
