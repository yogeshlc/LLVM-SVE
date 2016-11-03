// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
mad     z23.h, p3/m, z8.h, z13.h  // 00000100-01001000-11001101-10110111
// CHECK: mad     z23.h, p3/m, z8.h, z13.h // encoding: [0xb7,0xcd,0x48,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01001000-11001101-10110111
MAD     Z23.H, P3/M, Z8.H, Z13.H  // 00000100-01001000-11001101-10110111
// CHECK: mad     z23.h, p3/m, z8.h, z13.h // encoding: [0xb7,0xcd,0x48,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01001000-11001101-10110111
mad     z31.h, p7/m, z31.h, z31.h  // 00000100-01011111-11011111-11111111
// CHECK: mad     z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0xdf,0x5f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011111-11011111-11111111
MAD     Z31.H, P7/M, Z31.H, Z31.H  // 00000100-01011111-11011111-11111111
// CHECK: mad     z31.h, p7/m, z31.h, z31.h // encoding: [0xff,0xdf,0x5f,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011111-11011111-11111111
mad     z0.h, p0/m, z0.h, z0.h  // 00000100-01000000-11000000-00000000
// CHECK: mad     z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0xc0,0x40,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000000-11000000-00000000
MAD     Z0.H, P0/M, Z0.H, Z0.H  // 00000100-01000000-11000000-00000000
// CHECK: mad     z0.h, p0/m, z0.h, z0.h // encoding: [0x00,0xc0,0x40,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01000000-11000000-00000000
mad     z21.h, p5/m, z21.h, z10.h  // 00000100-01010101-11010101-01010101
// CHECK: mad     z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0xd5,0x55,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010101-11010101-01010101
MAD     Z21.H, P5/M, Z21.H, Z10.H  // 00000100-01010101-11010101-01010101
// CHECK: mad     z21.h, p5/m, z21.h, z10.h // encoding: [0x55,0xd5,0x55,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01010101-11010101-01010101
