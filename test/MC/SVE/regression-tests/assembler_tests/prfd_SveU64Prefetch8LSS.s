// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
prfd    pldl3strm, p5, [x10, x21, lsl #3]  // 10000101-10010101-11010101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, x21, lsl #3] // encoding: [0x45,0xd5,0x95,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10010101-11010101-01000101
PRFD    PLDL3STRM, P5, [X10, X21, LSL #3]  // 10000101-10010101-11010101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, x21, lsl #3] // encoding: [0x45,0xd5,0x95,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10010101-11010101-01000101
prfd    #7, p3, [x13, x8, lsl #3]  // 10000101-10001000-11001101-10100111
// CHECK: prfd    #7, p3, [x13, x8, lsl #3] // encoding: [0xa7,0xcd,0x88,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10001000-11001101-10100111
PRFD    #7, P3, [X13, X8, LSL #3]  // 10000101-10001000-11001101-10100111
// CHECK: prfd    #7, p3, [x13, x8, lsl #3] // encoding: [0xa7,0xcd,0x88,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10001000-11001101-10100111
prfd    pldl3strm, p3, [x17, x16, lsl #3]  // 10000101-10010000-11001110-00100101
// CHECK: prfd    pldl3strm, p3, [x17, x16, lsl #3] // encoding: [0x25,0xce,0x90,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10010000-11001110-00100101
PRFD    PLDL3STRM, P3, [X17, X16, LSL #3]  // 10000101-10010000-11001110-00100101
// CHECK: prfd    pldl3strm, p3, [x17, x16, lsl #3] // encoding: [0x25,0xce,0x90,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10010000-11001110-00100101
prfd    pldl1keep, p0, [x0, x0, lsl #3]  // 10000101-10000000-11000000-00000000
// CHECK: prfd    pldl1keep, p0, [x0, x0, lsl #3] // encoding: [0x00,0xc0,0x80,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10000000-11000000-00000000
PRFD    PLDL1KEEP, P0, [X0, X0, LSL #3]  // 10000101-10000000-11000000-00000000
// CHECK: prfd    pldl1keep, p0, [x0, x0, lsl #3] // encoding: [0x00,0xc0,0x80,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-10000000-11000000-00000000
