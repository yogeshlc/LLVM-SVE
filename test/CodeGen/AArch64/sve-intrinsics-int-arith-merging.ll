; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; ABS
;

define <n x 16 x i8> @abs_i8(<n x 16 x i8> %a, <n x 16 x i1> %pg, <n x 16 x i8> %b) {
; CHECK-LABEL: abs_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: abs z0.b, p0/m, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.abs.nxv16i8(<n x 16 x i8> %a,
                                                          <n x 16 x i1> %pg,
                                                          <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @abs_i16(<n x 8 x i16> %a, <n x 8 x i1> %pg, <n x 8 x i16> %b) {
; CHECK-LABEL: abs_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: abs z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<n x 8 x i16> %a,
                                                          <n x 8 x i1> %pg,
                                                          <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @abs_i32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: abs_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: abs z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.abs.nxv4i32(<n x 4 x i32> %a,
                                                          <n x 4 x i1> %pg,
                                                          <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @abs_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: abs_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: abs z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.abs.nxv2i64(<n x 2 x i64> %a,
                                                          <n x 2 x i1> %pg,
                                                          <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; ADD
;

define <n x 16 x i8> @add_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: add_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: add z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.add.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a,
                                                          <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @add_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: add_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: add z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.add.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a,
                                                          <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @add_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: add_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: add z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.add.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a,
                                                          <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @add_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: add_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: add z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.add.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a,
                                                          <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; MUL
;

define <n x 16 x i8> @mul_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: mul_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: mul z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.mul.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a,
                                                          <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @mul_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: mul_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: mul z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.mul.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a,
                                                          <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @mul_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: mul_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: mul z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.mul.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a,
                                                          <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @mul_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: mul_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: mul z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.mul.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a,
                                                          <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; NEG
;

define <n x 16 x i8> @neg_i8(<n x 16 x i8> %a, <n x 16 x i1> %pg, <n x 16 x i8> %b) {
; CHECK-LABEL: neg_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: neg z0.b, p0/m, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.neg.nxv16i8(<n x 16 x i8> %a,
                                                          <n x 16 x i1> %pg,
                                                          <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @neg_i16(<n x 8 x i16> %a, <n x 8 x i1> %pg, <n x 8 x i16> %b) {
; CHECK-LABEL: neg_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: neg z0.h, p0/m, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.neg.nxv8i16(<n x 8 x i16> %a,
                                                          <n x 8 x i1> %pg,
                                                          <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @neg_i32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: neg_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: neg z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.neg.nxv4i32(<n x 4 x i32> %a,
                                                          <n x 4 x i1> %pg,
                                                          <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @neg_i64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: neg_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: neg z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.neg.nxv2i64(<n x 2 x i64> %a,
                                                          <n x 2 x i1> %pg,
                                                          <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; SABD
;

define <n x 16 x i8> @sabd_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: sabd_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: sabd z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.sabd.nxv16i8(<n x 16 x i1> %pg,
                                                           <n x 16 x i8> %a,
                                                           <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @sabd_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: sabd_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: sabd z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.sabd.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @sabd_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: sabd_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: sabd z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.sabd.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sabd_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: sabd_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: sabd z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.sabd.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

; SDIV

define <n x 4 x i32> @sdiv_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: sdiv_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: sdiv z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.sdiv.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sdiv_d(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: sdiv_d:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: sdiv z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.sdiv.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

; SDIVR

define <n x 4 x i32> @sdivr_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: sdivr_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: sdivr z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.sdivr.nxv4i32(<n x 4 x i1> %pg,
                                                            <n x 4 x i32> %a,
                                                            <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sdivr_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: sdivr_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: sdivr z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.sdivr.nxv2i64(<n x 2 x i1> %pg,
                                                            <n x 2 x i64> %a,
                                                            <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; SMIN
;

define <n x 16 x i8> @smin_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: smin_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: smin z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.smin.nxv16i8(<n x 16 x i1> %pg,
                                                           <n x 16 x i8> %a,
                                                           <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @smin_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: smin_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: smin z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.smin.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @smin_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: smin_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: smin z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.smin.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @smin_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: smin_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: smin z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.smin.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; SMAX
;

define <n x 16 x i8> @smax_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: smax_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: smax z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.smax.nxv16i8(<n x 16 x i1> %pg,
                                                           <n x 16 x i8> %a,
                                                           <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @smax_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: smax_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: smax z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.smax.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @smax_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: smax_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: smax z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.smax.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @smax_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: smax_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: smax z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.smax.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; SMULH
;

define <n x 16 x i8> @smulh_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: smulh_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: smulh z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.smulh.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %a,
                                                            <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @smulh_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: smulh_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: smulh z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.smulh.nxv8i16(<n x 8 x i1> %pg,
                                                            <n x 8 x i16> %a,
                                                            <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @smulh_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: smulh_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: smulh z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.smulh.nxv4i32(<n x 4 x i1> %pg,
                                                            <n x 4 x i32> %a,
                                                            <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @smulh_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: smulh_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: smulh z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.smulh.nxv2i64(<n x 2 x i1> %pg,
                                                            <n x 2 x i64> %a,
                                                            <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; SUB
;

define <n x 16 x i8> @sub_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: sub_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: sub z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.sub.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a,
                                                          <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @sub_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: sub_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: sub z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.sub.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a,
                                                          <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @sub_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: sub_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: sub z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.sub.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a,
                                                          <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @sub_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: sub_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: sub z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.sub.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a,
                                                          <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; SUBR
;

define <n x 16 x i8> @subr_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: subr_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: subr z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.subr.nxv16i8(<n x 16 x i1> %pg,
                                                          <n x 16 x i8> %a,
                                                          <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @subr_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: subr_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: subr z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.subr.nxv8i16(<n x 8 x i1> %pg,
                                                          <n x 8 x i16> %a,
                                                          <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @subr_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: subr_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: subr z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.subr.nxv4i32(<n x 4 x i1> %pg,
                                                          <n x 4 x i32> %a,
                                                          <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @subr_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: subr_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: subr z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.subr.nxv2i64(<n x 2 x i1> %pg,
                                                          <n x 2 x i64> %a,
                                                          <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; UABD
;

define <n x 16 x i8> @uabd_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: uabd_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: uabd z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.uabd.nxv16i8(<n x 16 x i1> %pg,
                                                           <n x 16 x i8> %a,
                                                           <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @uabd_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: uabd_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: uabd z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.uabd.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @uabd_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: uabd_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: uabd z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.uabd.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @uabd_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: uabd_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: uabd z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.uabd.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

; UDIV

define <n x 4 x i32> @udiv_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: udiv_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: udiv z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.udiv.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @udiv_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: udiv_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: udiv z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.udiv.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

; UDIVR

define <n x 4 x i32> @udivr_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: udivr_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: udivr z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.udivr.nxv4i32(<n x 4 x i1> %pg,
                                                            <n x 4 x i32> %a,
                                                            <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @udivr_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: udivr_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: udivr z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.udivr.nxv2i64(<n x 2 x i1> %pg,
                                                            <n x 2 x i64> %a,
                                                            <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; UMIN
;

define <n x 16 x i8> @umin_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: umin_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: umin z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.umin.nxv16i8(<n x 16 x i1> %pg,
                                                           <n x 16 x i8> %a,
                                                           <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @umin_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: umin_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: umin z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.umin.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @umin_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: umin_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: umin z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.umin.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @umin_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: umin_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: umin z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.umin.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; UMAX
;

define <n x 16 x i8> @umax_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: umax_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: umax z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.umax.nxv16i8(<n x 16 x i1> %pg,
                                                           <n x 16 x i8> %a,
                                                           <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @umax_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: umax_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: umax z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.umax.nxv8i16(<n x 8 x i1> %pg,
                                                           <n x 8 x i16> %a,
                                                           <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @umax_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: umax_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: umax z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.umax.nxv4i32(<n x 4 x i1> %pg,
                                                           <n x 4 x i32> %a,
                                                           <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @umax_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: umax_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: umax z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.umax.nxv2i64(<n x 2 x i1> %pg,
                                                           <n x 2 x i64> %a,
                                                           <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; UMULH
;

define <n x 16 x i8> @umulh_i8(<n x 16 x i1> %pg, <n x 16 x i8> %a, <n x 16 x i8> %b) {
; CHECK-LABEL: umulh_i8:
; CHECK:      movprfx z0.b, p0/z, z0.b
; CHECK-NEXT: umulh z0.b, p0/m, z0.b, z1.b
; CHECK-NEXT: ret
  %tmp = call <n x 16 x i8> @llvm.aarch64.sve.umulh.nxv16i8(<n x 16 x i1> %pg,
                                                            <n x 16 x i8> %a,
                                                            <n x 16 x i8> %b)
  %out = select <n x 16 x i1> %pg, <n x 16 x i8> %tmp, <n x 16 x i8> zeroinitializer
  ret <n x 16 x i8> %out
}

define <n x 8 x i16> @umulh_i16(<n x 8 x i1> %pg, <n x 8 x i16> %a, <n x 8 x i16> %b) {
; CHECK-LABEL: umulh_i16:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: umulh z0.h, p0/m, z0.h, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 8 x i16> @llvm.aarch64.sve.umulh.nxv8i16(<n x 8 x i1> %pg,
                                                            <n x 8 x i16> %a,
                                                            <n x 8 x i16> %b)
  %out = select <n x 8 x i1> %pg, <n x 8 x i16> %tmp, <n x 8 x i16> zeroinitializer
  ret <n x 8 x i16> %out
}

define <n x 4 x i32> @umulh_i32(<n x 4 x i1> %pg, <n x 4 x i32> %a, <n x 4 x i32> %b) {
; CHECK-LABEL: umulh_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: umulh z0.s, p0/m, z0.s, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.umulh.nxv4i32(<n x 4 x i1> %pg,
                                                            <n x 4 x i32> %a,
                                                            <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @umulh_i64(<n x 2 x i1> %pg, <n x 2 x i64> %a, <n x 2 x i64> %b) {
; CHECK-LABEL: umulh_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: umulh z0.d, p0/m, z0.d, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.umulh.nxv2i64(<n x 2 x i1> %pg,
                                                            <n x 2 x i64> %a,
                                                            <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

declare <n x 16 x i8> @llvm.aarch64.sve.abs.nxv16i8(<n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.abs.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.abs.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.abs.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.add.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.add.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.add.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.add.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.mad.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.mad.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.mad.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.mad.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.mla.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.mla.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.mla.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.mla.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.mls.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.mls.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.mls.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.mls.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.msb.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.msb.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.msb.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.msb.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.mul.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.mul.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.mul.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.mul.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.neg.nxv16i8(<n x 16 x i8>, <n x 16 x i1>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.neg.nxv8i16(<n x 8 x i16>, <n x 8 x i1>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.neg.nxv4i32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.neg.nxv2i64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.sabd.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.sabd.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.sabd.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.sabd.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 4 x i32> @llvm.aarch64.sve.sdiv.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.sdiv.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 4 x i32> @llvm.aarch64.sve.sdivr.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.sdivr.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.smax.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.smax.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.smax.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.smax.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.smin.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.smin.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.smin.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.smin.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.smulh.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.smulh.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.smulh.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.smulh.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.sqadd.nxv16i8(<n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.sqadd.nxv8i16(<n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.sqadd.nxv4i32(<n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.sqadd.nxv2i64(<n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.sqsub.nxv16i8(<n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.sqsub.nxv8i16(<n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.sqsub.nxv4i32(<n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.sqsub.nxv2i64(<n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.sub.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.sub.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.sub.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.sub.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.subr.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.subr.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.subr.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.subr.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.uabd.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.uabd.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.uabd.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.uabd.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 4 x i32> @llvm.aarch64.sve.udiv.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.udiv.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 4 x i32> @llvm.aarch64.sve.udivr.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.udivr.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.umax.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.umax.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.umax.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.umax.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.umin.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.umin.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.umin.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.umin.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.umulh.nxv16i8(<n x 16 x i1>, <n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.umulh.nxv8i16(<n x 8 x i1>, <n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.umulh.nxv4i32(<n x 4 x i1>, <n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.umulh.nxv2i64(<n x 2 x i1>, <n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.uqadd.nxv16i8(<n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.uqadd.nxv8i16(<n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.uqadd.nxv4i32(<n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.uqadd.nxv2i64(<n x 2 x i64>, <n x 2 x i64>)

declare <n x 16 x i8> @llvm.aarch64.sve.uqsub.nxv16i8(<n x 16 x i8>, <n x 16 x i8>)
declare <n x 8 x i16> @llvm.aarch64.sve.uqsub.nxv8i16(<n x 8 x i16>, <n x 8 x i16>)
declare <n x 4 x i32> @llvm.aarch64.sve.uqsub.nxv4i32(<n x 4 x i32>, <n x 4 x i32>)
declare <n x 2 x i64> @llvm.aarch64.sve.uqsub.nxv2i64(<n x 2 x i64>, <n x 2 x i64>)
