// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
movprfx z31.s, p7/m, z31.s  // 00000100-10010001-00111111-11111111
// CHECK: movprfx z31.s, p7/m, z31.s // encoding: [0xff,0x3f,0x91,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010001-00111111-11111111
MOVPRFX Z31.S, P7/M, Z31.S  // 00000100-10010001-00111111-11111111
// CHECK: movprfx z31.s, p7/m, z31.s // encoding: [0xff,0x3f,0x91,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010001-00111111-11111111
movprfx z21.s, p5/m, z10.s  // 00000100-10010001-00110101-01010101
// CHECK: movprfx z21.s, p5/m, z10.s // encoding: [0x55,0x35,0x91,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010001-00110101-01010101
MOVPRFX Z21.S, P5/M, Z10.S  // 00000100-10010001-00110101-01010101
// CHECK: movprfx z21.s, p5/m, z10.s // encoding: [0x55,0x35,0x91,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010001-00110101-01010101
movprfx z23.s, p3/m, z13.s  // 00000100-10010001-00101101-10110111
// CHECK: movprfx z23.s, p3/m, z13.s // encoding: [0xb7,0x2d,0x91,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010001-00101101-10110111
MOVPRFX Z23.S, P3/M, Z13.S  // 00000100-10010001-00101101-10110111
// CHECK: movprfx z23.s, p3/m, z13.s // encoding: [0xb7,0x2d,0x91,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010001-00101101-10110111
movprfx z0.s, p0/m, z0.s  // 00000100-10010001-00100000-00000000
// CHECK: movprfx z0.s, p0/m, z0.s // encoding: [0x00,0x20,0x91,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010001-00100000-00000000
MOVPRFX Z0.S, P0/M, Z0.S  // 00000100-10010001-00100000-00000000
// CHECK: movprfx z0.s, p0/m, z0.s // encoding: [0x00,0x20,0x91,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-10010001-00100000-00000000
