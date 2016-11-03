// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
prfb    pldl1keep, p0, [x0, z0.s, uxtw]  // 10000100-00100000-00000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, z0.s, uxtw] // encoding: [0x00,0x00,0x20,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00100000-00000000-00000000
PRFB    PLDL1KEEP, P0, [X0, Z0.S, UXTW]  // 10000100-00100000-00000000-00000000
// CHECK: prfb    pldl1keep, p0, [x0, z0.s, uxtw] // encoding: [0x00,0x00,0x20,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00100000-00000000-00000000
prfb    pldl3strm, p5, [x10, z21.s, uxtw]  // 10000100-00110101-00010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, z21.s, uxtw] // encoding: [0x45,0x15,0x35,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00110101-00010101-01000101
PRFB    PLDL3STRM, P5, [X10, Z21.S, UXTW]  // 10000100-00110101-00010101-01000101
// CHECK: prfb    pldl3strm, p5, [x10, z21.s, uxtw] // encoding: [0x45,0x15,0x35,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00110101-00010101-01000101
prfb    #15, p7, [sp, z31.s, uxtw]  // 10000100-00111111-00011111-11101111
// CHECK: prfb    #15, p7, [sp, z31.s, uxtw] // encoding: [0xef,0x1f,0x3f,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00111111-00011111-11101111
PRFB    #15, P7, [SP, Z31.S, UXTW]  // 10000100-00111111-00011111-11101111
// CHECK: prfb    #15, p7, [sp, z31.s, uxtw] // encoding: [0xef,0x1f,0x3f,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00111111-00011111-11101111
prfb    #7, p3, [x13, z8.s, uxtw]  // 10000100-00101000-00001101-10100111
// CHECK: prfb    #7, p3, [x13, z8.s, uxtw] // encoding: [0xa7,0x0d,0x28,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00101000-00001101-10100111
PRFB    #7, P3, [X13, Z8.S, UXTW]  // 10000100-00101000-00001101-10100111
// CHECK: prfb    #7, p3, [x13, z8.s, uxtw] // encoding: [0xa7,0x0d,0x28,0x84]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 10000100-00101000-00001101-10100111
