// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
prfd    pldl1keep, p0, [z0.d]  // 11000101-10000000-11100000-00000000
// CHECK: prfd    pldl1keep, p0, [z0.d] // encoding: [0x00,0xe0,0x80,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10000000-11100000-00000000
PRFD    PLDL1KEEP, P0, [Z0.D]  // 11000101-10000000-11100000-00000000
// CHECK: prfd    pldl1keep, p0, [z0.d] // encoding: [0x00,0xe0,0x80,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10000000-11100000-00000000
prfd    #7, p3, [z13.d, #64]  // 11000101-10001000-11101101-10100111
// CHECK: prfd    #7, p3, [z13.d, #64] // encoding: [0xa7,0xed,0x88,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10001000-11101101-10100111
PRFD    #7, P3, [Z13.D, #64]  // 11000101-10001000-11101101-10100111
// CHECK: prfd    #7, p3, [z13.d, #64] // encoding: [0xa7,0xed,0x88,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10001000-11101101-10100111
prfd    pldl3strm, p5, [z10.d, #168]  // 11000101-10010101-11110101-01000101
// CHECK: prfd    pldl3strm, p5, [z10.d, #168] // encoding: [0x45,0xf5,0x95,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10010101-11110101-01000101
PRFD    PLDL3STRM, P5, [Z10.D, #168]  // 11000101-10010101-11110101-01000101
// CHECK: prfd    pldl3strm, p5, [z10.d, #168] // encoding: [0x45,0xf5,0x95,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10010101-11110101-01000101
prfd    #15, p7, [z31.d, #248]  // 11000101-10011111-11111111-11101111
// CHECK: prfd    #15, p7, [z31.d, #248] // encoding: [0xef,0xff,0x9f,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10011111-11111111-11101111
PRFD    #15, P7, [Z31.D, #248]  // 11000101-10011111-11111111-11101111
// CHECK: prfd    #15, p7, [z31.d, #248] // encoding: [0xef,0xff,0x9f,0xc5]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000101-10011111-11111111-11101111
