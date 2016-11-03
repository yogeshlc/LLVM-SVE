// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
prfb    pldl3strm, p3, [x17, x16]  // 10000100-00010000-11001110-00100101
// CHECK: prfb    pldl3strm, p3, [x17, x16] // encoding: [0x25,0xce,0x10,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00010000-11001110-00100101
PRFB    PLDL3STRM, P3, [X17, X16]  // 10000100-00010000-11001110-00100101
// CHECK: prfb    pldl3strm, p3, [x17, x16] // encoding: [0x25,0xce,0x10,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00010000-11001110-00100101
prfb    #7, p3, [x13, x8]  // 10000100-00001000-11001101-10100111
// CHECK: prfb    #7, p3, [x13, x8] // encoding: [0xa7,0xcd,0x08,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00001000-11001101-10100111
PRFB    #7, P3, [X13, X8]  // 10000100-00001000-11001101-10100111
// CHECK: prfb    #7, p3, [x13, x8] // encoding: [0xa7,0xcd,0x08,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00001000-11001101-10100111
prfb    pldl1keep, p0, [x0, x0]  // 10000100-00000000-11000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, x0] // encoding: [0x00,0xc0,0x00,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00000000-11000000-00000000
PRFB    PLDL1KEEP, P0, [X0, X0]  // 10000100-00000000-11000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, x0] // encoding: [0x00,0xc0,0x00,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00000000-11000000-00000000
prfb    pldl3strm, p5, [x10, x21]  // 10000100-00010101-11010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, x21] // encoding: [0x45,0xd5,0x15,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00010101-11010101-01000101
PRFB    PLDL3STRM, P5, [X10, X21]  // 10000100-00010101-11010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, x21] // encoding: [0x45,0xd5,0x15,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00010101-11010101-01000101
