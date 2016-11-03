// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
prfd    #15, p7, [sp, z31.d, uxtw #3]  // 11000100-00111111-01111111-11101111
// CHECK: prfd    #15, p7, [sp, z31.d, uxtw #3] // encoding: [0xef,0x7f,0x3f,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-00111111-01111111-11101111
PRFD    #15, P7, [SP, Z31.D, UXTW #3]  // 11000100-00111111-01111111-11101111
// CHECK: prfd    #15, p7, [sp, z31.d, uxtw #3] // encoding: [0xef,0x7f,0x3f,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-00111111-01111111-11101111
prfd    pldl3strm, p5, [x10, z21.d, uxtw #3]  // 11000100-00110101-01110101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, z21.d, uxtw #3] // encoding: [0x45,0x75,0x35,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-00110101-01110101-01000101
PRFD    PLDL3STRM, P5, [X10, Z21.D, UXTW #3]  // 11000100-00110101-01110101-01000101
// CHECK: prfd    pldl3strm, p5, [x10, z21.d, uxtw #3] // encoding: [0x45,0x75,0x35,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-00110101-01110101-01000101
prfd    pldl1keep, p0, [x0, z0.d, uxtw #3]  // 11000100-00100000-01100000-00000000
// CHECK: prfd    pldl1keep, p0, [x0, z0.d, uxtw #3] // encoding: [0x00,0x60,0x20,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-00100000-01100000-00000000
PRFD    PLDL1KEEP, P0, [X0, Z0.D, UXTW #3]  // 11000100-00100000-01100000-00000000
// CHECK: prfd    pldl1keep, p0, [x0, z0.d, uxtw #3] // encoding: [0x00,0x60,0x20,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-00100000-01100000-00000000
prfd    #7, p3, [x13, z8.d, uxtw #3]  // 11000100-00101000-01101101-10100111
// CHECK: prfd    #7, p3, [x13, z8.d, uxtw #3] // encoding: [0xa7,0x6d,0x28,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-00101000-01101101-10100111
PRFD    #7, P3, [X13, Z8.D, UXTW #3]  // 11000100-00101000-01101101-10100111
// CHECK: prfd    #7, p3, [x13, z8.d, uxtw #3] // encoding: [0xa7,0x6d,0x28,0xc4]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 11000100-00101000-01101101-10100111
