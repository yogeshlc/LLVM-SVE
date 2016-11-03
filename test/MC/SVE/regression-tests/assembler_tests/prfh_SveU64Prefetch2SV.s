// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
prfh    pldl1keep, p0, [x0, z0.d, lsl #1]  // 11000100-01100000-10100000-00000000
// CHECK: prfh    pldl1keep, p0, [x0, z0.d, lsl #1] // encoding: [0x00,0xa0,0x60,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-01100000-10100000-00000000
PRFH    PLDL1KEEP, P0, [X0, Z0.D, LSL #1]  // 11000100-01100000-10100000-00000000
// CHECK: prfh    pldl1keep, p0, [x0, z0.d, lsl #1] // encoding: [0x00,0xa0,0x60,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-01100000-10100000-00000000
prfh    #7, p3, [x13, z8.d, lsl #1]  // 11000100-01101000-10101101-10100111
// CHECK: prfh    #7, p3, [x13, z8.d, lsl #1] // encoding: [0xa7,0xad,0x68,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-01101000-10101101-10100111
PRFH    #7, P3, [X13, Z8.D, LSL #1]  // 11000100-01101000-10101101-10100111
// CHECK: prfh    #7, p3, [x13, z8.d, lsl #1] // encoding: [0xa7,0xad,0x68,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-01101000-10101101-10100111
prfh    #15, p7, [sp, z31.d, lsl #1]  // 11000100-01111111-10111111-11101111
// CHECK: prfh    #15, p7, [sp, z31.d, lsl #1] // encoding: [0xef,0xbf,0x7f,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-01111111-10111111-11101111
PRFH    #15, P7, [SP, Z31.D, LSL #1]  // 11000100-01111111-10111111-11101111
// CHECK: prfh    #15, p7, [sp, z31.d, lsl #1] // encoding: [0xef,0xbf,0x7f,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-01111111-10111111-11101111
prfh    pldl3strm, p5, [x10, z21.d, lsl #1]  // 11000100-01110101-10110101-01000101
// CHECK: prfh    pldl3strm, p5, [x10, z21.d, lsl #1] // encoding: [0x45,0xb5,0x75,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-01110101-10110101-01000101
PRFH    PLDL3STRM, P5, [X10, Z21.D, LSL #1]  // 11000100-01110101-10110101-01000101
// CHECK: prfh    pldl3strm, p5, [x10, z21.d, lsl #1] // encoding: [0x45,0xb5,0x75,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-01110101-10110101-01000101
