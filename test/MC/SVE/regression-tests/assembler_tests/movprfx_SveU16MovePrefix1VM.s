// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
movprfx z31.h, p7/m, z31.h  // 00000100-01010001-00111111-11111111
// CHECK: movprfx z31.h, p7/m, z31.h // encoding: [0xff,0x3f,0x51,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010001-00111111-11111111
MOVPRFX Z31.H, P7/M, Z31.H  // 00000100-01010001-00111111-11111111
// CHECK: movprfx z31.h, p7/m, z31.h // encoding: [0xff,0x3f,0x51,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010001-00111111-11111111
movprfx z0.h, p0/m, z0.h  // 00000100-01010001-00100000-00000000
// CHECK: movprfx z0.h, p0/m, z0.h // encoding: [0x00,0x20,0x51,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010001-00100000-00000000
MOVPRFX Z0.H, P0/M, Z0.H  // 00000100-01010001-00100000-00000000
// CHECK: movprfx z0.h, p0/m, z0.h // encoding: [0x00,0x20,0x51,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010001-00100000-00000000
movprfx z23.h, p3/m, z13.h  // 00000100-01010001-00101101-10110111
// CHECK: movprfx z23.h, p3/m, z13.h // encoding: [0xb7,0x2d,0x51,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010001-00101101-10110111
MOVPRFX Z23.H, P3/M, Z13.H  // 00000100-01010001-00101101-10110111
// CHECK: movprfx z23.h, p3/m, z13.h // encoding: [0xb7,0x2d,0x51,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010001-00101101-10110111
movprfx z21.h, p5/m, z10.h  // 00000100-01010001-00110101-01010101
// CHECK: movprfx z21.h, p5/m, z10.h // encoding: [0x55,0x35,0x51,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010001-00110101-01010101
MOVPRFX Z21.H, P5/M, Z10.H  // 00000100-01010001-00110101-01010101
// CHECK: movprfx z21.h, p5/m, z10.h // encoding: [0x55,0x35,0x51,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010001-00110101-01010101
