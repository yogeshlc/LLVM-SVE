// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmpls   p15.h, p7/z, z31.h, z31.h  // 00100100-01011111-00011111-11101111
// CHECK: cmphs   p15.h, p7/z, z31.h, z31.h // encoding: [0xef,0x1f,0x5f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01011111-00011111-11101111
CMPLS   P15.H, P7/Z, Z31.H, Z31.H  // 00100100-01011111-00011111-11101111
// CHECK: cmphs   p15.h, p7/z, z31.h, z31.h // encoding: [0xef,0x1f,0x5f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01011111-00011111-11101111
cmpls   p7.h, p3/z, z8.h, z13.h  // 00100100-01001000-00001101-10100111
// CHECK: cmphs   p7.h, p3/z, z13.h, z8.h // encoding: [0xa7,0x0d,0x48,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01001000-00001101-10100111
CMPLS   P7.H, P3/Z, Z8.H, Z13.H  // 00100100-01001000-00001101-10100111
// CHECK: cmphs   p7.h, p3/z, z13.h, z8.h // encoding: [0xa7,0x0d,0x48,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01001000-00001101-10100111
cmpls   p0.h, p0/z, z0.h, z0.h  // 00100100-01000000-00000000-00000000
// CHECK: cmphs   p0.h, p0/z, z0.h, z0.h // encoding: [0x00,0x00,0x40,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01000000-00000000-00000000
CMPLS   P0.H, P0/Z, Z0.H, Z0.H  // 00100100-01000000-00000000-00000000
// CHECK: cmphs   p0.h, p0/z, z0.h, z0.h // encoding: [0x00,0x00,0x40,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01000000-00000000-00000000
cmpls   p5.h, p5/z, z21.h, z10.h  // 00100100-01010101-00010101-01000101
// CHECK: cmphs   p5.h, p5/z, z10.h, z21.h // encoding: [0x45,0x15,0x55,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01010101-00010101-01000101
CMPLS   P5.H, P5/Z, Z21.H, Z10.H  // 00100100-01010101-00010101-01000101
// CHECK: cmphs   p5.h, p5/z, z10.h, z21.h // encoding: [0x45,0x15,0x55,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01010101-00010101-01000101
