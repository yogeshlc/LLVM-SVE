# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0x25,0xce,0x10,0x84
# CHECK: prfb    pldl3strm, p3, [x17, x16] // encoding: [0x25,0xce,0x10,0x84]
# CHECK-ERROR-NOT: prfb    pldl3strm, p3, [x17, x16] 
0xa7,0xcd,0x08,0x84
# CHECK: prfb    #7, p3, [x13, x8] // encoding: [0xa7,0xcd,0x08,0x84]
# CHECK-ERROR-NOT: prfb    #7, p3, [x13, x8] 
0x00,0xc0,0x00,0x84
# CHECK: prfb    pldl1keep, p0, [x0, x0] // encoding: [0x00,0xc0,0x00,0x84]
# CHECK-ERROR-NOT: prfb    pldl1keep, p0, [x0, x0] 
0x45,0xd5,0x15,0x84
# CHECK: prfb    pldl3strm, p5, [x10, x21] // encoding: [0x45,0xd5,0x15,0x84]
# CHECK-ERROR-NOT: prfb    pldl3strm, p5, [x10, x21] 
