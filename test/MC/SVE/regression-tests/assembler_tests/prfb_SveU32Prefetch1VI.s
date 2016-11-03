// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
prfb    #15, p7, [z31.s, #31]  // 10000100-00011111-11111111-11101111
// CHECK: prfb    #15, p7, [z31.s, #31] // encoding: [0xef,0xff,0x1f,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00011111-11111111-11101111
PRFB    #15, P7, [Z31.S, #31]  // 10000100-00011111-11111111-11101111
// CHECK: prfb    #15, p7, [z31.s, #31] // encoding: [0xef,0xff,0x1f,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00011111-11111111-11101111
prfb    pldl1keep, p0, [z0.s]  // 10000100-00000000-11100000-00000000
// CHECK: prfb    pldl1keep, p0, [z0.s] // encoding: [0x00,0xe0,0x00,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00000000-11100000-00000000
PRFB    PLDL1KEEP, P0, [Z0.S]  // 10000100-00000000-11100000-00000000
// CHECK: prfb    pldl1keep, p0, [z0.s] // encoding: [0x00,0xe0,0x00,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00000000-11100000-00000000
prfb    #7, p3, [z13.s, #8]  // 10000100-00001000-11101101-10100111
// CHECK: prfb    #7, p3, [z13.s, #8] // encoding: [0xa7,0xed,0x08,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00001000-11101101-10100111
PRFB    #7, P3, [Z13.S, #8]  // 10000100-00001000-11101101-10100111
// CHECK: prfb    #7, p3, [z13.s, #8] // encoding: [0xa7,0xed,0x08,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00001000-11101101-10100111
prfb    pldl3strm, p5, [z10.s, #21]  // 10000100-00010101-11110101-01000101
// CHECK: prfb    pldl3strm, p5, [z10.s, #21] // encoding: [0x45,0xf5,0x15,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00010101-11110101-01000101
PRFB    PLDL3STRM, P5, [Z10.S, #21]  // 10000100-00010101-11110101-01000101
// CHECK: prfb    pldl3strm, p5, [z10.s, #21] // encoding: [0x45,0xf5,0x15,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00010101-11110101-01000101
