# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xb7,0xcd,0xd8,0x05
# CHECK: fmov    z23.d, p8/m, #0.90625{{0*}} // encoding: [0xb7,0xcd,0xd8,0x05]
# CHECK-ERROR-NOT: fmov    z23.d, p8/m, #0.90625{{0*}} 
0x55,0xd5,0xd5,0x05
# CHECK: fmov    z21.d, p5/m, #-13.0{{0*}} // encoding: [0x55,0xd5,0xd5,0x05]
# CHECK-ERROR-NOT: fmov    z21.d, p5/m, #-13.0{{0*}} 
0xff,0xdf,0xdf,0x05
# CHECK: fmov    z31.d, p15/m, #-1.9375{{0*}} // encoding: [0xff,0xdf,0xdf,0x05]
# CHECK-ERROR-NOT: fmov    z31.d, p15/m, #-1.9375{{0*}} 
0x00,0xc0,0xd0,0x05
# CHECK: fmov    z0.d, p0/m, #2.0{{0*}} // encoding: [0x00,0xc0,0xd0,0x05]
# CHECK-ERROR-NOT: fmov    z0.d, p0/m, #2.0{{0*}} 
