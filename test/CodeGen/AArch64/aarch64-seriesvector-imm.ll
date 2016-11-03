; RUN: llc -verify-machineinstrs -o - %s -mtriple=aarch64 -mattr=+sve | FileCheck %s --check-prefix=CHECK

;; 8 bit variants

define <n x 16 x i8> @seriesvec_b() {
; CHECK-LABEL: seriesvec_b:
; CHECK: index z0.b, #1, #1
; CHECK-NEXT: ret
  %index = seriesvector i8 1, 1 as <n x 16 x i8>
  ret <n x 16 x i8> %index
}

;;check immediates with negative values
define <n x 16 x i8> @seriesvec_nb() {
; CHECK-LABEL: seriesvec_nb:
; CHECK: index z0.b, #-1, #-1
; CHECK-NEXT: ret
  %index = seriesvector i8 -1, -1 as <n x 16 x i8>
  ret <n x 16 x i8> %index
}

;;check immediates with values greater equal than 32
define <n x 16 x i8> @seriesvec_gb() {
; CHECK-LABEL: seriesvec_gb:
; CHECK: index z0.b, {{w[0-9]+}}, {{w[0-9]+}}
; CHECK-NEXT: ret
  %index = seriesvector i8 32, 32 as <n x 16 x i8>
  ret <n x 16 x i8> %index
}

;;check immediates with values less than -32
define <n x 16 x i8> @seriesvec_sb() {
; CHECK-LABEL: seriesvec_sb:
; CHECK: index z0.b, {{w[0-9]+}}, {{w[0-9]+}}
; CHECK-NEXT: ret
  %index = seriesvector i8 -33, -33 as <n x 16 x i8>
  ret <n x 16 x i8> %index
}

;; check with small immediate start and larger step
define <n x 16 x i8> @seriesvec_irb() {
; CHECK-LABEL: seriesvec_irb:
; CHECK: index z0.b, #7, {{w[0-9]+}}
; CHECK-NEXT: ret
  %index = seriesvector i8 7, 17 as <n x 16 x i8>
  ret <n x 16 x i8> %index
}

;; 16 bit variants

define <n x 8 x i16> @seriesvec_h() {
; CHECK-LABEL: seriesvec_h:
; CHECK: index z0.h, #1, #1
; CHECK-NEXT: ret
  %index = seriesvector i16 1, 1 as <n x 8 x i16>
  ret <n x 8 x i16> %index
}

;;check immediates with negative values
define <n x 8 x i16> @seriesvec_nh() {
; CHECK-LABEL: seriesvec_nh:
; CHECK: index z0.h, #-1, #-1
; CHECK-NEXT: ret
  %index = seriesvector i16 -1, -1 as <n x 8 x i16>
  ret <n x 8 x i16> %index
}

;;check immediates with values greater equal than 32
define <n x 8 x i16> @seriesvec_gh() {
; CHECK-LABEL: seriesvec_gh:
; CHECK: index z0.h, {{w[0-9]+}}, {{w[0-9]+}}
; CHECK-NEXT: ret
  %index = seriesvector i16 32, 32 as <n x 8 x i16>
  ret <n x 8 x i16> %index
}

;;check immediates with values less than -32
define <n x 8 x i16> @seriesvec_sh() {
; CHECK-LABEL: seriesvec_sh:
; CHECK: index z0.h, {{w[0-9]+}}, {{w[0-9]+}}
; CHECK-NEXT: ret
  %index = seriesvector i16 -33, -33 as <n x 8 x i16>
  ret <n x 8 x i16> %index
}

;; check with small immediate start and larger step
define <n x 8 x i16> @seriesvec_irh() {
; CHECK-LABEL: seriesvec_irh:
; CHECK: index z0.h, #7, {{w[0-9]+}}
; CHECK-NEXT: ret
  %index = seriesvector i16 7, 17 as <n x 8 x i16>
  ret <n x 8 x i16> %index
}

;; 32 bit variants

define <n x 4 x i32> @seriesvec_s() {
; CHECK-LABEL: seriesvec_s:
; CHECK: index z0.s, #1, #1
; CHECK-NEXT: ret
  %index = seriesvector i32 1, 1 as <n x 4 x i32>
  ret <n x 4 x i32> %index
}

;;check immediates with negative values
define <n x 4 x i32> @seriesvec_ns() {
; CHECK-LABEL: seriesvec_ns:
; CHECK: index z0.s, #-1, #-1
; CHECK-NEXT: ret
  %index = seriesvector i32 -1, -1 as <n x 4 x i32>
  ret <n x 4 x i32> %index
}

;;check immediates with values greater equal than 32
define <n x 4 x i32> @seriesvec_gs() {
; CHECK-LABEL: seriesvec_gs:
; CHECK: index z0.s, {{w[0-9]+}}, {{w[0-9]+}}
; CHECK-NEXT: ret
  %index = seriesvector i32 32, 32 as <n x 4 x i32>
  ret <n x 4 x i32> %index
}

;;check immediates with values less than -32
define <n x 4 x i32> @seriesvec_ss() {
; CHECK-LABEL: seriesvec_ss:
; CHECK: index z0.s, {{w[0-9]+}}, {{w[0-9]+}}
; CHECK-NEXT: ret
  %index = seriesvector i32 -33, -33 as <n x 4 x i32>
  ret <n x 4 x i32> %index
}

;; check with small immediate start and larger step
define <n x 4 x i32> @seriesvec_irs() {
; CHECK-LABEL: seriesvec_irs:
; CHECK: index z0.s, #7, {{w[0-9]+}}
; CHECK-NEXT: ret
  %index = seriesvector i32 7, 17 as <n x 4 x i32>
  ret <n x 4 x i32> %index
}

;; 64 bit variants

define <n x 2 x i64> @seriesvec_d() {
; CHECK-LABEL: seriesvec_d:
; CHECK: index z0.d, #1, #1
; CHECK-NEXT: ret
  %index = seriesvector i64 1, 1 as <n x 2 x i64>
  ret <n x 2 x i64> %index
}

;;check immediates with negative values
define <n x 2 x i64> @seriesvec_nd() {
; CHECK-LABEL: seriesvec_nd:
; CHECK: index z0.d, #-1, #-1
; CHECK-NEXT: ret
  %index = seriesvector i64 -1, -1 as <n x 2 x i64>
  ret <n x 2 x i64> %index
}

;;check immediates with values greater equal than 32
define <n x 2 x i64> @seriesvec_gd() {
; CHECK-LABEL: seriesvec_gd:
; CHECK: index z0.d, {{x[0-9]+}}, {{x[0-9]+}}
; CHECK-NEXT: ret
  %index = seriesvector i64 32, 32 as <n x 2 x i64>
  ret <n x 2 x i64> %index
}

;;check immediates with values less than -32
define <n x 2 x i64> @seriesvec_sd() {
; CHECK-LABEL: seriesvec_sd:
; CHECK: index z0.d, {{x[0-9]+}}, {{x[0-9]+}}
; CHECK-NEXT: ret
  %index = seriesvector i64 -33, -33 as <n x 2 x i64>
  ret <n x 2 x i64> %index
}

;; check with small immediate start and larger step
define <n x 2 x i64> @seriesvec_ird() {
; CHECK-LABEL: seriesvec_ird:
; CHECK: index z0.d, #7, {{x[0-9]+}}
; CHECK-NEXT: ret
  %index = seriesvector i64 7, 17 as <n x 2 x i64>
  ret <n x 2 x i64> %index
}
