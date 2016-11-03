# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x55,0x39,0x64,0x05
# CHECK: insr    z21.h, w10 // encoding: [0x55,0x39,0x64,0x05]
# CHECK-ERROR-NOT: insr    z21.h, w10 
0xff,0x3b,0x64,0x05
# CHECK: insr    z31.h, wzr // encoding: [0xff,0x3b,0x64,0x05]
# CHECK-ERROR-NOT: insr    z31.h, wzr 
0x00,0x38,0x64,0x05
# CHECK: insr    z0.h, w0 // encoding: [0x00,0x38,0x64,0x05]
# CHECK-ERROR-NOT: insr    z0.h, w0 
0xb7,0x39,0x64,0x05
# CHECK: insr    z23.h, w13 // encoding: [0xb7,0x39,0x64,0x05]
# CHECK-ERROR-NOT: insr    z23.h, w13 
