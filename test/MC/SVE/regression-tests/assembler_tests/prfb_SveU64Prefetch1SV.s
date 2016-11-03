// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
prfb    pldl3strm, p5, [x10, z21.d]  // 11000100-01110101-10010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, z21.d] // encoding: [0x45,0x95,0x75,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-01110101-10010101-01000101
PRFB    PLDL3STRM, P5, [X10, Z21.D]  // 11000100-01110101-10010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, z21.d] // encoding: [0x45,0x95,0x75,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-01110101-10010101-01000101
prfb    pldl1keep, p0, [x0, z0.d]  // 11000100-01100000-10000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, z0.d] // encoding: [0x00,0x80,0x60,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-01100000-10000000-00000000
PRFB    PLDL1KEEP, P0, [X0, Z0.D]  // 11000100-01100000-10000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, z0.d] // encoding: [0x00,0x80,0x60,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-01100000-10000000-00000000
prfb    #15, p7, [sp, z31.d]  // 11000100-01111111-10011111-11101111
// CHECK: prfb    #15, p7, [sp, z31.d] // encoding: [0xef,0x9f,0x7f,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-01111111-10011111-11101111
PRFB    #15, P7, [SP, Z31.D]  // 11000100-01111111-10011111-11101111
// CHECK: prfb    #15, p7, [sp, z31.d] // encoding: [0xef,0x9f,0x7f,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-01111111-10011111-11101111
prfb    #7, p3, [x13, z8.d]  // 11000100-01101000-10001101-10100111
// CHECK: prfb    #7, p3, [x13, z8.d] // encoding: [0xa7,0x8d,0x68,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-01101000-10001101-10100111
PRFB    #7, P3, [X13, Z8.D]  // 11000100-01101000-10001101-10100111
// CHECK: prfb    #7, p3, [x13, z8.d] // encoding: [0xa7,0x8d,0x68,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-01101000-10001101-10100111
