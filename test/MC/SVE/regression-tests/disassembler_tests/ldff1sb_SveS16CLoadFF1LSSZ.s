# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=+sve < %s | FileCheck %s
# RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -disassemble -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR  %s
0xff,0x7f,0xdf,0xa5
# CHECK: ldff1sb {z31.h}, p7/z, [sp, xzr] // encoding: [0xff,0x7f,0xdf,0xa5]
# CHECK-ERROR-NOT: ldff1sb {z31.h}, p7/z, [sp, xzr] 
0x00,0x60,0xc0,0xa5
# CHECK: ldff1sb {z0.h}, p0/z, [x0, x0] // encoding: [0x00,0x60,0xc0,0xa5]
# CHECK-ERROR-NOT: ldff1sb {z0.h}, p0/z, [x0, x0] 
0x55,0x75,0xd5,0xa5
# CHECK: ldff1sb {z21.h}, p5/z, [x10, x21] // encoding: [0x55,0x75,0xd5,0xa5]
# CHECK-ERROR-NOT: ldff1sb {z21.h}, p5/z, [x10, x21] 
0xb7,0x6d,0xc8,0xa5
# CHECK: ldff1sb {z23.h}, p3/z, [x13, x8] // encoding: [0xb7,0x6d,0xc8,0xa5]
# CHECK-ERROR-NOT: ldff1sb {z23.h}, p3/z, [x13, x8] 
