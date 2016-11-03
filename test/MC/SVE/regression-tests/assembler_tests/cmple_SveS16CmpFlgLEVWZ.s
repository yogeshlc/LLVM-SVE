// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmple   p15.h, p7/z, z31.h, z31.d  // 00100100-01011111-01111111-11111111
// CHECK: cmple   p15.h, p7/z, z31.h, z31.d // encoding: [0xff,0x7f,0x5f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01011111-01111111-11111111
CMPLE   P15.H, P7/Z, Z31.H, Z31.D  // 00100100-01011111-01111111-11111111
// CHECK: cmple   p15.h, p7/z, z31.h, z31.d // encoding: [0xff,0x7f,0x5f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01011111-01111111-11111111
cmple   p0.h, p0/z, z0.h, z0.d  // 00100100-01000000-01100000-00010000
// CHECK: cmple   p0.h, p0/z, z0.h, z0.d // encoding: [0x10,0x60,0x40,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01000000-01100000-00010000
CMPLE   P0.H, P0/Z, Z0.H, Z0.D  // 00100100-01000000-01100000-00010000
// CHECK: cmple   p0.h, p0/z, z0.h, z0.d // encoding: [0x10,0x60,0x40,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01000000-01100000-00010000
cmple   p5.h, p5/z, z10.h, z21.d  // 00100100-01010101-01110101-01010101
// CHECK: cmple   p5.h, p5/z, z10.h, z21.d // encoding: [0x55,0x75,0x55,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01010101-01110101-01010101
CMPLE   P5.H, P5/Z, Z10.H, Z21.D  // 00100100-01010101-01110101-01010101
// CHECK: cmple   p5.h, p5/z, z10.h, z21.d // encoding: [0x55,0x75,0x55,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01010101-01110101-01010101
cmple   p7.h, p3/z, z13.h, z8.d  // 00100100-01001000-01101101-10110111
// CHECK: cmple   p7.h, p3/z, z13.h, z8.d // encoding: [0xb7,0x6d,0x48,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01001000-01101101-10110111
CMPLE   P7.H, P3/Z, Z13.H, Z8.D  // 00100100-01001000-01101101-10110111
// CHECK: cmple   p7.h, p3/z, z13.h, z8.d // encoding: [0xb7,0x6d,0x48,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01001000-01101101-10110111
