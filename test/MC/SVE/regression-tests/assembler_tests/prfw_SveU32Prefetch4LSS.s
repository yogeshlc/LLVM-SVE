// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
prfw    pldl1keep, p0, [x0, x0, lsl #2]  // 10000101-00000000-11000000-00000000
// CHECK: prfw    pldl1keep, p0, [x0, x0, lsl #2] // encoding: [0x00,0xc0,0x00,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00000000-11000000-00000000
PRFW    PLDL1KEEP, P0, [X0, X0, LSL #2]  // 10000101-00000000-11000000-00000000
// CHECK: prfw    pldl1keep, p0, [x0, x0, lsl #2] // encoding: [0x00,0xc0,0x00,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00000000-11000000-00000000
prfw    #7, p3, [x13, x8, lsl #2]  // 10000101-00001000-11001101-10100111
// CHECK: prfw    #7, p3, [x13, x8, lsl #2] // encoding: [0xa7,0xcd,0x08,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00001000-11001101-10100111
PRFW    #7, P3, [X13, X8, LSL #2]  // 10000101-00001000-11001101-10100111
// CHECK: prfw    #7, p3, [x13, x8, lsl #2] // encoding: [0xa7,0xcd,0x08,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00001000-11001101-10100111
prfw    pldl3strm, p3, [x17, x16, lsl #2]  // 10000101-00010000-11001110-00100101
// CHECK: prfw    pldl3strm, p3, [x17, x16, lsl #2] // encoding: [0x25,0xce,0x10,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00010000-11001110-00100101
PRFW    PLDL3STRM, P3, [X17, X16, LSL #2]  // 10000101-00010000-11001110-00100101
// CHECK: prfw    pldl3strm, p3, [x17, x16, lsl #2] // encoding: [0x25,0xce,0x10,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00010000-11001110-00100101
prfw    pldl3strm, p5, [x10, x21, lsl #2]  // 10000101-00010101-11010101-01000101
// CHECK: prfw    pldl3strm, p5, [x10, x21, lsl #2] // encoding: [0x45,0xd5,0x15,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00010101-11010101-01000101
PRFW    PLDL3STRM, P5, [X10, X21, LSL #2]  // 10000101-00010101-11010101-01000101
// CHECK: prfw    pldl3strm, p5, [x10, x21, lsl #2] // encoding: [0x45,0xd5,0x15,0x85]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000101-00010101-11010101-01000101
