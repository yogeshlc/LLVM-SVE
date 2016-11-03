; RUN: llc -mtriple=aarch64-linux-gnu -mattr=+sve < %s | FileCheck %s

;
; FCVT
;

define <n x 8 x half> @fcvt_f16_f32(<n x 8 x half> %a, <n x 16 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: fcvt_f16_f32:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fcvt z0.h, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 8 x half> @llvm.aarch64.sve.fcvt.f16f32(<n x 8 x half> %a,
                                                           <n x 16 x i1> %pg,
                                                           <n x 4 x float> %b)
  %pg2 = call <n x 8 x i1> @llvm.aarch64.sve.reinterpret.bool.h.nxv16i1(<n x 16 x i1> %pg)
  %out = select <n x 8 x i1> %pg2, <n x 8 x half> %tmp, <n x 8 x half> zeroinitializer
  ret <n x 8 x half> %out
}

define <n x 8 x half> @fcvt_f16_f64(<n x 8 x half> %a, <n x 16 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: fcvt_f16_f64:
; CHECK:      movprfx z0.h, p0/z, z0.h
; CHECK-NEXT: fcvt z0.h, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 8 x half> @llvm.aarch64.sve.fcvt.f16f64(<n x 8 x half> %a,
                                                           <n x 16 x i1> %pg,
                                                           <n x 2 x double> %b)
  %pg2 = call <n x 8 x i1> @llvm.aarch64.sve.reinterpret.bool.h.nxv16i1(<n x 16 x i1> %pg)
  %out = select <n x 8 x i1> %pg2, <n x 8 x half> %tmp, <n x 8 x half> zeroinitializer
  ret <n x 8 x half> %out
}

define <n x 4 x float> @fcvt_f32_f16(<n x 4 x float> %a, <n x 16 x i1> %pg, <n x 8 x half> %b) {
; CHECK-LABEL: fcvt_f32_f16:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fcvt z0.s, p0/m, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.fcvt.f32f16(<n x 4 x float> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 8 x half> %b)
  %pg2 = call <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv16i1(<n x 16 x i1> %pg)
  %out = select <n x 4 x i1> %pg2, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 4 x float> @fcvt_f32_f64(<n x 4 x float> %a, <n x 16 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: fcvt_f32_f64:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fcvt z0.s, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.fcvt.f32f64(<n x 4 x float> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 2 x double> %b)
  %pg2 = call <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv16i1(<n x 16 x i1> %pg)
  %out = select <n x 4 x i1> %pg2, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @fcvt_f64_f16(<n x 2 x double> %a, <n x 16 x i1> %pg, <n x 8 x half> %b) {
; CHECK-LABEL: fcvt_f64_f16:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fcvt z0.d, p0/m, z1.h
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.fcvt.f64f16(<n x 2 x double> %a,
                                                             <n x 16 x i1> %pg,
                                                             <n x 8 x half> %b)
  %pg2 = call <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv16i1(<n x 16 x i1> %pg)
  %out = select <n x 2 x i1> %pg2, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

define <n x 2 x double> @fcvt_f64_f32(<n x 2 x double> %a, <n x 16 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: fcvt_f64_f32:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fcvt z0.d, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.fcvt.f64f32(<n x 2 x double> %a,
                                                             <n x 16 x i1> %pg,
                                                             <n x 4 x float> %b)
  %pg2 = call <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv16i1(<n x 16 x i1> %pg)
  %out = select <n x 2 x i1> %pg2, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; FCVTZS
;

define <n x 4 x i32> @fcvtzs_i32_f32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: fcvtzs_i32_f32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fcvtzs z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.fcvtzs.nxv4i32.nxv4f32(<n x 4 x i32> %a,
                                                                     <n x 4 x i1> %pg,
                                                                     <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @fcvtzs_i64_f64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: fcvtzs_i64_f64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fcvtzs z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.fcvtzs.nxv2i64.nxv2f64(<n x 2 x i64> %a,
                                                                     <n x 2 x i1> %pg,
                                                                     <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

define <n x 4 x i32> @fcvtzs_i32_f64(<n x 4 x i32> %a, <n x 16 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: fcvtzs_i32_f64:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fcvtzs z0.s, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.fcvtzs.i32f64(<n x 4 x i32> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 2 x double> %b)
  %pg2 = call <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv16i1(<n x 16 x i1> %pg)
  %out = select <n x 4 x i1> %pg2, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @fcvtzs_i64_f32(<n x 2 x i64> %a, <n x 16 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: fcvtzs_i64_f32:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fcvtzs z0.d, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.fcvtzs.i64f32(<n x 2 x i64> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 4 x float> %b)
  %pg2 = call <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv16i1(<n x 16 x i1> %pg)
  %out = select <n x 2 x i1> %pg2, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; FCVTZU
;

define <n x 4 x i32> @fcvtzu_i32_f32(<n x 4 x i32> %a, <n x 4 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: fcvtzu_i32_f32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fcvtzu z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.fcvtzu.nxv4i32.nxv4f32(<n x 4 x i32> %a,
                                                                     <n x 4 x i1> %pg,
                                                                     <n x 4 x float> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @fcvtzu_i64_f64(<n x 2 x i64> %a, <n x 2 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: fcvtzu_i64_f64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fcvtzu z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.fcvtzu.nxv2i64.nxv2f64(<n x 2 x i64> %a,
                                                                     <n x 2 x i1> %pg,
                                                                     <n x 2 x double> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

define <n x 4 x i32> @fcvtzu_i32_f64(<n x 4 x i32> %a, <n x 16 x i1> %pg, <n x 2 x double> %b) {
; CHECK-LABEL: fcvtzu_i32_f64:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: fcvtzu z0.s, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 4 x i32> @llvm.aarch64.sve.fcvtzu.i32f64(<n x 4 x i32> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 2 x double> %b)
  %pg2 = call <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv16i1(<n x 16 x i1> %pg)
  %out = select <n x 4 x i1> %pg2, <n x 4 x i32> %tmp, <n x 4 x i32> zeroinitializer
  ret <n x 4 x i32> %out
}

define <n x 2 x i64> @fcvtzu_i64_f32(<n x 2 x i64> %a, <n x 16 x i1> %pg, <n x 4 x float> %b) {
; CHECK-LABEL: fcvtzu_i64_f32:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: fcvtzu z0.d, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 2 x i64> @llvm.aarch64.sve.fcvtzu.i64f32(<n x 2 x i64> %a,
                                                            <n x 16 x i1> %pg,
                                                            <n x 4 x float> %b)
  %pg2 = call <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv16i1(<n x 16 x i1> %pg)
  %out = select <n x 2 x i1> %pg2, <n x 2 x i64> %tmp, <n x 2 x i64> zeroinitializer
  ret <n x 2 x i64> %out
}

;
; SCVTF
;

define <n x 4 x float> @scvtf_f32_i32(<n x 4 x float> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: scvtf_f32_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: scvtf z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.scvtf.nxv4f32.nxv4i32(<n x 4 x float> %a,
                                                                      <n x 4 x i1> %pg,
                                                                      <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @scvtf_f64_i64(<n x 2 x double> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: scvtf_f64_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: scvtf z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.scvtf.nxv2f64.nxv2i64(<n x 2 x double> %a,
                                                                       <n x 2 x i1> %pg,
                                                                       <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

define <n x 4 x float> @scvtf_f32_i64(<n x 4 x float> %a, <n x 16 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: scvtf_f32_i64:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: scvtf z0.s, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.scvtf.f32i64(<n x 4 x float> %a,
                                                             <n x 16 x i1> %pg,
                                                             <n x 2 x i64> %b)
  %pg2 = call <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv16i1(<n x 16 x i1> %pg)
  %out = select <n x 4 x i1> %pg2, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @scvtf_f64_i32(<n x 2 x double> %a, <n x 16 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: scvtf_f64_i32:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: scvtf z0.d, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.scvtf.f64i32(<n x 2 x double> %a,
                                                              <n x 16 x i1> %pg,
                                                              <n x 4 x i32> %b)
  %pg2 = call <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv16i1(<n x 16 x i1> %pg)
  %out = select <n x 2 x i1> %pg2, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

;
; UCVTF
;

define <n x 4 x float> @ucvtf_f32_i32(<n x 4 x float> %a, <n x 4 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: ucvtf_f32_i32:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: ucvtf z0.s, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.ucvtf.nxv4f32.nxv4i32(<n x 4 x float> %a,
                                                                      <n x 4 x i1> %pg,
                                                                      <n x 4 x i32> %b)
  %out = select <n x 4 x i1> %pg, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @ucvtf_f64_i64(<n x 2 x double> %a, <n x 2 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: ucvtf_f64_i64:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: ucvtf z0.d, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.ucvtf.nxv2f64.nxv2i64(<n x 2 x double> %a,
                                                                       <n x 2 x i1> %pg,
                                                                       <n x 2 x i64> %b)
  %out = select <n x 2 x i1> %pg, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

define <n x 4 x float> @ucvtf_f32_i64(<n x 4 x float> %a, <n x 16 x i1> %pg, <n x 2 x i64> %b) {
; CHECK-LABEL: ucvtf_f32_i64:
; CHECK:      movprfx z0.s, p0/z, z0.s
; CHECK-NEXT: ucvtf z0.s, p0/m, z1.d
; CHECK-NEXT: ret
  %tmp = call <n x 4 x float> @llvm.aarch64.sve.ucvtf.f32i64(<n x 4 x float> %a,
                                                             <n x 16 x i1> %pg,
                                                             <n x 2 x i64> %b)
  %pg2 = call <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv16i1(<n x 16 x i1> %pg)
  %out = select <n x 4 x i1> %pg2, <n x 4 x float> %tmp, <n x 4 x float> zeroinitializer
  ret <n x 4 x float> %out
}

define <n x 2 x double> @ucvtf_f64_i32(<n x 2 x double> %a, <n x 16 x i1> %pg, <n x 4 x i32> %b) {
; CHECK-LABEL: ucvtf_f64_i32:
; CHECK:      movprfx z0.d, p0/z, z0.d
; CHECK-NEXT: ucvtf z0.d, p0/m, z1.s
; CHECK-NEXT: ret
  %tmp = call <n x 2 x double> @llvm.aarch64.sve.ucvtf.f64i32(<n x 2 x double> %a,
                                                              <n x 16 x i1> %pg,
                                                              <n x 4 x i32> %b)
  %pg2 = call <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv16i1(<n x 16 x i1> %pg)
  %out = select <n x 2 x i1> %pg2, <n x 2 x double> %tmp, <n x 2 x double> zeroinitializer
  ret <n x 2 x double> %out
}

declare <n x 8 x half> @llvm.aarch64.sve.fcvt.f16f32(<n x 8 x half>, <n x 16 x i1>, <n x 4 x float>)
declare <n x 8 x half> @llvm.aarch64.sve.fcvt.f16f64(<n x 8 x half>, <n x 16 x i1>, <n x 2 x double>)
declare <n x 4 x float> @llvm.aarch64.sve.fcvt.f32f16(<n x 4 x float>, <n x 16 x i1>, <n x 8 x half>)
declare <n x 4 x float> @llvm.aarch64.sve.fcvt.f32f64(<n x 4 x float>, <n x 16 x i1>, <n x 2 x double>)
declare <n x 2 x double> @llvm.aarch64.sve.fcvt.f64f16(<n x 2 x double>, <n x 16 x i1>, <n x 8 x half>)
declare <n x 2 x double> @llvm.aarch64.sve.fcvt.f64f32(<n x 2 x double>, <n x 16 x i1>, <n x 4 x float>)

declare <n x 4 x i32> @llvm.aarch64.sve.fcvtzs.nxv4i32.nxv4f32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x i64> @llvm.aarch64.sve.fcvtzs.nxv2i64.nxv2f64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x double>)
declare <n x 4 x i32> @llvm.aarch64.sve.fcvtzs.i32f64(<n x 4 x i32>, <n x 16 x i1>, <n x 2 x double>)
declare <n x 2 x i64> @llvm.aarch64.sve.fcvtzs.i64f32(<n x 2 x i64>, <n x 16 x i1>, <n x 4 x float>)

declare <n x 4 x i32> @llvm.aarch64.sve.fcvtzu.nxv4i32.nxv4f32(<n x 4 x i32>, <n x 4 x i1>, <n x 4 x float>)
declare <n x 2 x i64> @llvm.aarch64.sve.fcvtzu.nxv2i64.nxv2f64(<n x 2 x i64>, <n x 2 x i1>, <n x 2 x double>)
declare <n x 4 x i32> @llvm.aarch64.sve.fcvtzu.i32f64(<n x 4 x i32>, <n x 16 x i1>, <n x 2 x double>)
declare <n x 2 x i64> @llvm.aarch64.sve.fcvtzu.i64f32(<n x 2 x i64>, <n x 16 x i1>, <n x 4 x float>)

declare <n x 4 x float> @llvm.aarch64.sve.scvtf.nxv4f32.nxv4i32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x double> @llvm.aarch64.sve.scvtf.nxv2f64.nxv2i64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x i64>)
declare <n x 4 x float> @llvm.aarch64.sve.scvtf.f32i64(<n x 4 x float>, <n x 16 x i1>, <n x 2 x i64>)
declare <n x 2 x double> @llvm.aarch64.sve.scvtf.f64i32(<n x 2 x double>, <n x 16 x i1>, <n x 4 x i32>)

declare <n x 4 x float> @llvm.aarch64.sve.ucvtf.nxv4f32.nxv4i32(<n x 4 x float>, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 2 x double> @llvm.aarch64.sve.ucvtf.nxv2f64.nxv2i64(<n x 2 x double>, <n x 2 x i1>, <n x 2 x i64>)
declare <n x 4 x float> @llvm.aarch64.sve.ucvtf.f32i64(<n x 4 x float>, <n x 16 x i1>, <n x 2 x i64>)
declare <n x 2 x double> @llvm.aarch64.sve.ucvtf.f64i32(<n x 2 x double>, <n x 16 x i1>, <n x 4 x i32>)

declare <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv16i1(<n x 16 x i1>)
declare <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv8i1(<n x 8 x i1>)
declare <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv4i1(<n x 4 x i1>)
declare <n x 16 x i1> @llvm.aarch64.sve.reinterpret.bool.b.nxv2i1(<n x 2 x i1>)
declare <n x 8 x i1> @llvm.aarch64.sve.reinterpret.bool.h.nxv16i1(<n x 16 x i1>)
declare <n x 8 x i1> @llvm.aarch64.sve.reinterpret.bool.h.nxv8i1(<n x 8 x i1>)
declare <n x 8 x i1> @llvm.aarch64.sve.reinterpret.bool.h.nxv4i1(<n x 4 x i1>)
declare <n x 8 x i1> @llvm.aarch64.sve.reinterpret.bool.h.nxv2i1(<n x 2 x i1>)
declare <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv16i1(<n x 16 x i1>)
declare <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv8i1(<n x 8 x i1>)
declare <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv4i1(<n x 4 x i1>)
declare <n x 4 x i1> @llvm.aarch64.sve.reinterpret.bool.w.nxv2i1(<n x 2 x i1>)
declare <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv16i1(<n x 16 x i1>)
declare <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv8i1(<n x 8 x i1>)
declare <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv4i1(<n x 4 x i1>)
declare <n x 2 x i1> @llvm.aarch64.sve.reinterpret.bool.d.nxv2i1(<n x 2 x i1>)

