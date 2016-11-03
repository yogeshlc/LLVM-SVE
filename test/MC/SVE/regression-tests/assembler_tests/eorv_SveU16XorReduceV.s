// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
eorv    h0, p0, z0.h  // 00000100-01011001-00100000-00000000
// CHECK: eorv    h0, p0, z0.h // encoding: [0x00,0x20,0x59,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011001-00100000-00000000
EORV    H0, P0, Z0.H  // 00000100-01011001-00100000-00000000
// CHECK: eorv    h0, p0, z0.h // encoding: [0x00,0x20,0x59,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011001-00100000-00000000
eorv    h23, p3, z13.h  // 00000100-01011001-00101101-10110111
// CHECK: eorv    h23, p3, z13.h // encoding: [0xb7,0x2d,0x59,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011001-00101101-10110111
EORV    H23, P3, Z13.H  // 00000100-01011001-00101101-10110111
// CHECK: eorv    h23, p3, z13.h // encoding: [0xb7,0x2d,0x59,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011001-00101101-10110111
eorv    h21, p5, z10.h  // 00000100-01011001-00110101-01010101
// CHECK: eorv    h21, p5, z10.h // encoding: [0x55,0x35,0x59,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011001-00110101-01010101
EORV    H21, P5, Z10.H  // 00000100-01011001-00110101-01010101
// CHECK: eorv    h21, p5, z10.h // encoding: [0x55,0x35,0x59,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011001-00110101-01010101
eorv    h31, p7, z31.h  // 00000100-01011001-00111111-11111111
// CHECK: eorv    h31, p7, z31.h // encoding: [0xff,0x3f,0x59,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011001-00111111-11111111
EORV    H31, P7, Z31.H  // 00000100-01011001-00111111-11111111
// CHECK: eorv    h31, p7, z31.h // encoding: [0xff,0x3f,0x59,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011001-00111111-11111111
