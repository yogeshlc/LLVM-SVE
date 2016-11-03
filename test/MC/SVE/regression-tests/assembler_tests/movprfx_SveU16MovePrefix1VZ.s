// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
movprfx z21.h, p5/z, z10.h  // 00000100-01010000-00110101-01010101
// CHECK: movprfx z21.h, p5/z, z10.h // encoding: [0x55,0x35,0x50,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010000-00110101-01010101
MOVPRFX Z21.H, P5/Z, Z10.H  // 00000100-01010000-00110101-01010101
// CHECK: movprfx z21.h, p5/z, z10.h // encoding: [0x55,0x35,0x50,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010000-00110101-01010101
movprfx z23.h, p3/z, z13.h  // 00000100-01010000-00101101-10110111
// CHECK: movprfx z23.h, p3/z, z13.h // encoding: [0xb7,0x2d,0x50,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010000-00101101-10110111
MOVPRFX Z23.H, P3/Z, Z13.H  // 00000100-01010000-00101101-10110111
// CHECK: movprfx z23.h, p3/z, z13.h // encoding: [0xb7,0x2d,0x50,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010000-00101101-10110111
movprfx z0.h, p0/z, z0.h  // 00000100-01010000-00100000-00000000
// CHECK: movprfx z0.h, p0/z, z0.h // encoding: [0x00,0x20,0x50,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010000-00100000-00000000
MOVPRFX Z0.H, P0/Z, Z0.H  // 00000100-01010000-00100000-00000000
// CHECK: movprfx z0.h, p0/z, z0.h // encoding: [0x00,0x20,0x50,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010000-00100000-00000000
movprfx z31.h, p7/z, z31.h  // 00000100-01010000-00111111-11111111
// CHECK: movprfx z31.h, p7/z, z31.h // encoding: [0xff,0x3f,0x50,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010000-00111111-11111111
MOVPRFX Z31.H, P7/Z, Z31.H  // 00000100-01010000-00111111-11111111
// CHECK: movprfx z31.h, p7/z, z31.h // encoding: [0xff,0x3f,0x50,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010000-00111111-11111111
