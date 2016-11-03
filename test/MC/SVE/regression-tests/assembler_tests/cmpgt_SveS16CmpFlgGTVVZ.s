// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cmpgt   p5.h, p5/z, z10.h, z21.h  // 00100100-01010101-10010101-01010101
// CHECK: cmpgt   p5.h, p5/z, z10.h, z21.h // encoding: [0x55,0x95,0x55,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01010101-10010101-01010101
CMPGT   P5.H, P5/Z, Z10.H, Z21.H  // 00100100-01010101-10010101-01010101
// CHECK: cmpgt   p5.h, p5/z, z10.h, z21.h // encoding: [0x55,0x95,0x55,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01010101-10010101-01010101
cmpgt   p0.h, p0/z, z0.h, z0.h  // 00100100-01000000-10000000-00010000
// CHECK: cmpgt   p0.h, p0/z, z0.h, z0.h // encoding: [0x10,0x80,0x40,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01000000-10000000-00010000
CMPGT   P0.H, P0/Z, Z0.H, Z0.H  // 00100100-01000000-10000000-00010000
// CHECK: cmpgt   p0.h, p0/z, z0.h, z0.h // encoding: [0x10,0x80,0x40,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01000000-10000000-00010000
cmpgt   p7.h, p3/z, z13.h, z8.h  // 00100100-01001000-10001101-10110111
// CHECK: cmpgt   p7.h, p3/z, z13.h, z8.h // encoding: [0xb7,0x8d,0x48,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01001000-10001101-10110111
CMPGT   P7.H, P3/Z, Z13.H, Z8.H  // 00100100-01001000-10001101-10110111
// CHECK: cmpgt   p7.h, p3/z, z13.h, z8.h // encoding: [0xb7,0x8d,0x48,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01001000-10001101-10110111
cmpgt   p15.h, p7/z, z31.h, z31.h  // 00100100-01011111-10011111-11111111
// CHECK: cmpgt   p15.h, p7/z, z31.h, z31.h // encoding: [0xff,0x9f,0x5f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01011111-10011111-11111111
CMPGT   P15.H, P7/Z, Z31.H, Z31.H  // 00100100-01011111-10011111-11111111
// CHECK: cmpgt   p15.h, p7/z, z31.h, z31.h // encoding: [0xff,0x9f,0x5f,0x24]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00100100-01011111-10011111-11111111
