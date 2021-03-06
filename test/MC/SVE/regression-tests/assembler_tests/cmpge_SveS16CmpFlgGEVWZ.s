// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmpge   p7.h, p3/z, z13.h, z8.d  // 00100100-01001000-01001101-10100111
// CHECK: cmpge   p7.h, p3/z, z13.h, z8.d // encoding: [0xa7,0x4d,0x48,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01001000-01001101-10100111
CMPGE   P7.H, P3/Z, Z13.H, Z8.D  // 00100100-01001000-01001101-10100111
// CHECK: cmpge   p7.h, p3/z, z13.h, z8.d // encoding: [0xa7,0x4d,0x48,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01001000-01001101-10100111
cmpge   p0.h, p0/z, z0.h, z0.d  // 00100100-01000000-01000000-00000000
// CHECK: cmpge   p0.h, p0/z, z0.h, z0.d // encoding: [0x00,0x40,0x40,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01000000-01000000-00000000
CMPGE   P0.H, P0/Z, Z0.H, Z0.D  // 00100100-01000000-01000000-00000000
// CHECK: cmpge   p0.h, p0/z, z0.h, z0.d // encoding: [0x00,0x40,0x40,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01000000-01000000-00000000
cmpge   p5.h, p5/z, z10.h, z21.d  // 00100100-01010101-01010101-01000101
// CHECK: cmpge   p5.h, p5/z, z10.h, z21.d // encoding: [0x45,0x55,0x55,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01010101-01010101-01000101
CMPGE   P5.H, P5/Z, Z10.H, Z21.D  // 00100100-01010101-01010101-01000101
// CHECK: cmpge   p5.h, p5/z, z10.h, z21.d // encoding: [0x45,0x55,0x55,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01010101-01010101-01000101
cmpge   p15.h, p7/z, z31.h, z31.d  // 00100100-01011111-01011111-11101111
// CHECK: cmpge   p15.h, p7/z, z31.h, z31.d // encoding: [0xef,0x5f,0x5f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01011111-01011111-11101111
CMPGE   P15.H, P7/Z, Z31.H, Z31.D  // 00100100-01011111-01011111-11101111
// CHECK: cmpge   p15.h, p7/z, z31.h, z31.d // encoding: [0xef,0x5f,0x5f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01011111-01011111-11101111
