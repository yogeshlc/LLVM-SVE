// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
prfw    pldl3strm, p5, [z10.s, #84]  // 10000101-00010101-11110101-01000101
// CHECK: prfw    pldl3strm, p5, [z10.s, #84] // encoding: [0x45,0xf5,0x15,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00010101-11110101-01000101
PRFW    PLDL3STRM, P5, [Z10.S, #84]  // 10000101-00010101-11110101-01000101
// CHECK: prfw    pldl3strm, p5, [z10.s, #84] // encoding: [0x45,0xf5,0x15,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00010101-11110101-01000101
prfw    #7, p3, [z13.s, #32]  // 10000101-00001000-11101101-10100111
// CHECK: prfw    #7, p3, [z13.s, #32] // encoding: [0xa7,0xed,0x08,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00001000-11101101-10100111
PRFW    #7, P3, [Z13.S, #32]  // 10000101-00001000-11101101-10100111
// CHECK: prfw    #7, p3, [z13.s, #32] // encoding: [0xa7,0xed,0x08,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00001000-11101101-10100111
prfw    pldl1keep, p0, [z0.s]  // 10000101-00000000-11100000-00000000
// CHECK: prfw    pldl1keep, p0, [z0.s] // encoding: [0x00,0xe0,0x00,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00000000-11100000-00000000
PRFW    PLDL1KEEP, P0, [Z0.S]  // 10000101-00000000-11100000-00000000
// CHECK: prfw    pldl1keep, p0, [z0.s] // encoding: [0x00,0xe0,0x00,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00000000-11100000-00000000
prfw    #15, p7, [z31.s, #124]  // 10000101-00011111-11111111-11101111
// CHECK: prfw    #15, p7, [z31.s, #124] // encoding: [0xef,0xff,0x1f,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00011111-11111111-11101111
PRFW    #15, P7, [Z31.S, #124]  // 10000101-00011111-11111111-11101111
// CHECK: prfw    #15, p7, [z31.s, #124] // encoding: [0xef,0xff,0x1f,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00011111-11111111-11101111
