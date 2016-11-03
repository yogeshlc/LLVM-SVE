// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
prfh    #15, p7, [z31.s, #62]  // 10000100-10011111-11111111-11101111
// CHECK: prfh    #15, p7, [z31.s, #62] // encoding: [0xef,0xff,0x9f,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-10011111-11111111-11101111
PRFH    #15, P7, [Z31.S, #62]  // 10000100-10011111-11111111-11101111
// CHECK: prfh    #15, p7, [z31.s, #62] // encoding: [0xef,0xff,0x9f,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-10011111-11111111-11101111
prfh    pldl1keep, p0, [z0.s]  // 10000100-10000000-11100000-00000000
// CHECK: prfh    pldl1keep, p0, [z0.s] // encoding: [0x00,0xe0,0x80,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-10000000-11100000-00000000
PRFH    PLDL1KEEP, P0, [Z0.S]  // 10000100-10000000-11100000-00000000
// CHECK: prfh    pldl1keep, p0, [z0.s] // encoding: [0x00,0xe0,0x80,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-10000000-11100000-00000000
prfh    pldl3strm, p5, [z10.s, #42]  // 10000100-10010101-11110101-01000101
// CHECK: prfh    pldl3strm, p5, [z10.s, #42] // encoding: [0x45,0xf5,0x95,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-10010101-11110101-01000101
PRFH    PLDL3STRM, P5, [Z10.S, #42]  // 10000100-10010101-11110101-01000101
// CHECK: prfh    pldl3strm, p5, [z10.s, #42] // encoding: [0x45,0xf5,0x95,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-10010101-11110101-01000101
prfh    #7, p3, [z13.s, #16]  // 10000100-10001000-11101101-10100111
// CHECK: prfh    #7, p3, [z13.s, #16] // encoding: [0xa7,0xed,0x88,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-10001000-11101101-10100111
PRFH    #7, P3, [Z13.S, #16]  // 10000100-10001000-11101101-10100111
// CHECK: prfh    #7, p3, [z13.s, #16] // encoding: [0xa7,0xed,0x88,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-10001000-11101101-10100111
