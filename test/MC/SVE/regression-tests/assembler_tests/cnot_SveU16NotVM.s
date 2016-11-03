// RUN: llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=+sve < %s | FileCheck %s
// RUN: not llvm-mc -triple=aarch64-none-linux-gnu -show-encoding -mattr=-sve 2>&1 < %s | FileCheck --check-prefix=CHECK-ERROR %s
cnot    z0.h, p0/m, z0.h  // 00000100-01011011-10100000-00000000
// CHECK: cnot    z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x5b,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011011-10100000-00000000
CNOT    Z0.H, P0/M, Z0.H  // 00000100-01011011-10100000-00000000
// CHECK: cnot    z0.h, p0/m, z0.h // encoding: [0x00,0xa0,0x5b,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011011-10100000-00000000
cnot    z31.h, p7/m, z31.h  // 00000100-01011011-10111111-11111111
// CHECK: cnot    z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x5b,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011011-10111111-11111111
CNOT    Z31.H, P7/M, Z31.H  // 00000100-01011011-10111111-11111111
// CHECK: cnot    z31.h, p7/m, z31.h // encoding: [0xff,0xbf,0x5b,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011011-10111111-11111111
cnot    z21.h, p5/m, z10.h  // 00000100-01011011-10110101-01010101
// CHECK: cnot    z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x5b,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011011-10110101-01010101
CNOT    Z21.H, P5/M, Z10.H  // 00000100-01011011-10110101-01010101
// CHECK: cnot    z21.h, p5/m, z10.h // encoding: [0x55,0xb5,0x5b,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011011-10110101-01010101
cnot    z23.h, p3/m, z13.h  // 00000100-01011011-10101101-10110111
// CHECK: cnot    z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x5b,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011011-10101101-10110111
CNOT    Z23.H, P3/M, Z13.H  // 00000100-01011011-10101101-10110111
// CHECK: cnot    z23.h, p3/m, z13.h // encoding: [0xb7,0xad,0x5b,0x04]
// CHECK-ERROR: {{(unexpected token in argument list)|(invalid operand for instruction)|(invalid sve vector register)|(unexpected floating point literal)|(expected ']' in brackets expression)|(instruction requires: sve)|(vector register expected)|(immediate must be an integer in range \[-128, 127\] or a multiple of 256 in range \[-32768, 32512\])}}
// CHECK-ERROR-NEXT: 00000100-01011011-10101101-10110111
