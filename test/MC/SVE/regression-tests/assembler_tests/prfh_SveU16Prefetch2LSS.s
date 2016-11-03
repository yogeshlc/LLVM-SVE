// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
prfh    pldl3strm, p5, [x10, x21, lsl #1]  // 10000100-10010101-11010101-01000101
// CHECK: prfh    pldl3strm, p5, [x10, x21, lsl #1] // encoding: [0x45,0xd5,0x95,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-10010101-11010101-01000101
PRFH    PLDL3STRM, P5, [X10, X21, LSL #1]  // 10000100-10010101-11010101-01000101
// CHECK: prfh    pldl3strm, p5, [x10, x21, lsl #1] // encoding: [0x45,0xd5,0x95,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-10010101-11010101-01000101
prfh    pldl3strm, p3, [x17, x16, lsl #1]  // 10000100-10010000-11001110-00100101
// CHECK: prfh    pldl3strm, p3, [x17, x16, lsl #1] // encoding: [0x25,0xce,0x90,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-10010000-11001110-00100101
PRFH    PLDL3STRM, P3, [X17, X16, LSL #1]  // 10000100-10010000-11001110-00100101
// CHECK: prfh    pldl3strm, p3, [x17, x16, lsl #1] // encoding: [0x25,0xce,0x90,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-10010000-11001110-00100101
prfh    pldl1keep, p0, [x0, x0, lsl #1]  // 10000100-10000000-11000000-00000000
// CHECK: prfh    pldl1keep, p0, [x0, x0, lsl #1] // encoding: [0x00,0xc0,0x80,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-10000000-11000000-00000000
PRFH    PLDL1KEEP, P0, [X0, X0, LSL #1]  // 10000100-10000000-11000000-00000000
// CHECK: prfh    pldl1keep, p0, [x0, x0, lsl #1] // encoding: [0x00,0xc0,0x80,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-10000000-11000000-00000000
prfh    #7, p3, [x13, x8, lsl #1]  // 10000100-10001000-11001101-10100111
// CHECK: prfh    #7, p3, [x13, x8, lsl #1] // encoding: [0xa7,0xcd,0x88,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-10001000-11001101-10100111
PRFH    #7, P3, [X13, X8, LSL #1]  // 10000100-10001000-11001101-10100111
// CHECK: prfh    #7, p3, [x13, x8, lsl #1] // encoding: [0xa7,0xcd,0x88,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-10001000-11001101-10100111
