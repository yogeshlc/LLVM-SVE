// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
prfd    pldl3strm, p5, [x10, #21, mul vl]  // 10000101-11010101-01110101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, #21, mul vl] // encoding: [0x45,0x75,0xd5,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11010101-01110101-01000101
PRFD    PLDL3STRM, P5, [X10, #21, MUL VL]  // 10000101-11010101-01110101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, #21, mul vl] // encoding: [0x45,0x75,0xd5,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11010101-01110101-01000101
prfd    #7, p3, [x13, #8, mul vl]  // 10000101-11001000-01101101-10100111
// CHECK: prfd    #7, p3, [x13, #8, mul vl] // encoding: [0xa7,0x6d,0xc8,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11001000-01101101-10100111
PRFD    #7, P3, [X13, #8, MUL VL]  // 10000101-11001000-01101101-10100111
// CHECK: prfd    #7, p3, [x13, #8, mul vl] // encoding: [0xa7,0x6d,0xc8,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11001000-01101101-10100111
prfd    pldl1keep, p0, [x0]  // 10000101-11000000-01100000-00000000
// CHECK: prfd    pldl1keep, p0, [x0] // encoding: [0x00,0x60,0xc0,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11000000-01100000-00000000
PRFD    PLDL1KEEP, P0, [X0]  // 10000101-11000000-01100000-00000000
// CHECK: prfd    pldl1keep, p0, [x0] // encoding: [0x00,0x60,0xc0,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11000000-01100000-00000000
prfd    #15, p7, [sp, #-1, mul vl]  // 10000101-11111111-01111111-11101111
// CHECK: prfd    #15, p7, [sp, #-1, mul vl] // encoding: [0xef,0x7f,0xff,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11111111-01111111-11101111
PRFD    #15, P7, [SP, #-1, MUL VL]  // 10000101-11111111-01111111-11101111
// CHECK: prfd    #15, p7, [sp, #-1, mul vl] // encoding: [0xef,0x7f,0xff,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-11111111-01111111-11101111
