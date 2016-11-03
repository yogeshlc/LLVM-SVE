; RUN: llc -mtriple=aarch64--linux-gnu -mattr=+sve < %s | FileCheck %s

; CHECK-LABEL: @add_ss
; CHECK-DAG: ld1w {[[Z0:z[0-9]+]].s}, p{{[0-9]+}}/z, [x0]
; CHECK-DAG: ld1w {[[Z1:z[0-9]+]].s}, p{{[0-9]+}}/z, [x0, #1, mul vl]
; CHECK-DAG: ld1w {[[Z2:z[0-9]+]].s}, p{{[0-9]+}}/z, [x0, #2, mul vl]
; CHECK-DAG: ld1w {[[Z3:z[0-9]+]].s}, p{{[0-9]+}}/z, [x0, #3, mul vl]
; CHECK-DAG: st1w {[[Z0]].s}, p{{[0-9]+}}, [x1]
; CHECK-DAG: st1w {[[Z1]].s}, p{{[0-9]+}}, [x1, #1, mul vl]
; CHECK-DAG: st1w {[[Z2]].s}, p{{[0-9]+}}, [x1, #2, mul vl]
; CHECK-DAG: st1w {[[Z3]].s}, p{{[0-9]+}}, [x1, #3, mul vl]
define void @add_ss(<n x 16 x i32> *%a, <n x 16 x i32> *%b) {
  %in = load <n x 16 x i32> , <n x 16 x i32> *%a
  store <n x 16 x i32> %in, <n x 16 x i32> *%b
  ret void
}

; CHECK-LABEL: @add_dddd
; CHECK-DAG: ld1d {[[Z0:z[0-9]+]].d}, p{{[0-9]+}}/z, [x0]
; CHECK-DAG: ld1d {[[Z1:z[0-9]+]].d}, p{{[0-9]+}}/z, [x0, #1, mul vl]
; CHECK-DAG: ld1d {[[Z2:z[0-9]+]].d}, p{{[0-9]+}}/z, [x0, #2, mul vl]
; CHECK-DAG: ld1d {[[Z3:z[0-9]+]].d}, p{{[0-9]+}}/z, [x0, #3, mul vl]
; CHECK-DAG: ld1d {[[Z4:z[0-9]+]].d}, p{{[0-9]+}}/z, [x0, #4, mul vl]
; CHECK-DAG: ld1d {[[Z5:z[0-9]+]].d}, p{{[0-9]+}}/z, [x0, #5, mul vl]
; CHECK-DAG: ld1d {[[Z6:z[0-9]+]].d}, p{{[0-9]+}}/z, [x0, #6, mul vl]
; CHECK-DAG: ld1d {[[Z7:z[0-9]+]].d}, p{{[0-9]+}}/z, [x0, #7, mul vl]
; CHECK-DAG: st1d {[[Z0]].d}, p{{[0-9]+}}, [x1]
; CHECK-DAG: st1d {[[Z1]].d}, p{{[0-9]+}}, [x1, #1, mul vl]
; CHECK-DAG: st1d {[[Z2]].d}, p{{[0-9]+}}, [x1, #2, mul vl]
; CHECK-DAG: st1d {[[Z3]].d}, p{{[0-9]+}}, [x1, #3, mul vl]
; CHECK-DAG: st1d {[[Z4]].d}, p{{[0-9]+}}, [x1, #4, mul vl]
; CHECK-DAG: st1d {[[Z5]].d}, p{{[0-9]+}}, [x1, #5, mul vl]
; CHECK-DAG: st1d {[[Z6]].d}, p{{[0-9]+}}, [x1, #6, mul vl]
; CHECK-DAG: st1d {[[Z7]].d}, p{{[0-9]+}}, [x1, #7, mul vl]
define void @add_dddd(<n x 16 x i64> *%a, <n x 16 x i64> *%b) {
  %in = load <n x 16 x i64> , <n x 16 x i64> *%a
  store <n x 16 x i64> %in, <n x 16 x i64> *%b
  ret void
}


;; Base + scaled immediate offset using GEP
define void @valid_expressions(<n x 16 x i8> *%src, <n x 16 x i8> *%dest) {
; CHECK-LABEL: valid_expressions:
; CHECK-DAG: ld1b {[[DATA:z[0-9]+]].b}, p{{[0-9]+}}/z, [x0]
; CHECK-DAG: st1b {[[DATA]].b}, p{{[0-9]+}}, [x1, #2, mul vl]
; CHECK-DAG: ld1b {[[DATA:z[0-9]+]].b}, p{{[0-9]+}}/z, [x0, #3, mul vl]
; CHECK-DAG: st1b {[[DATA]].b}, p{{[0-9]+}}, [x1, #7, mul vl]
; CHECK-DAG: ld1b {[[DATA:z[0-9]+]].b}, p{{[0-9]+}}/z, [x0, #6, mul vl]
; CHECK-DAG: st1b {[[DATA]].b}, p{{[0-9]+}}, [x1, #-8, mul vl]
; CHECK-DAG: ld1b {[[DATA:z[0-9]+]].b}, p{{[0-9]+}}/z, [x0, #-1, mul vl]
; CHECK-DAG: st1b {[[DATA]].b}, p{{[0-9]+}}, [x1, #-2, mul vl]
; CHECK-DAG: st1b {[[DATA]].b}, p{{[0-9]+}}, [x1, #-3, mul vl]
; CHECK: ret
  %data1 = load <n x 16 x i8> , <n x 16 x i8> *%src
  %dest1 = getelementptr <n x 16 x i8>, <n x 16 x i8> *%dest, i64 2
  store <n x 16 x i8> %data1, <n x 16 x i8> *%dest1

  %src2 = getelementptr <n x 16 x i8>, <n x 16 x i8> *%src, i64 3
  %dest2 = getelementptr <n x 16 x i8>, <n x 16 x i8> *%dest, i64 7
  %data2 = load <n x 16 x i8> , <n x 16 x i8> *%src2
  store <n x 16 x i8> %data2, <n x 16 x i8> *%dest2

  %src3 = getelementptr <n x 16 x i8>, <n x 16 x i8> *%src, i64 6
  %dest3 = getelementptr <n x 16 x i8>, <n x 16 x i8> *%dest, i64 -8
  %data3 = load <n x 16 x i8> , <n x 16 x i8> *%src3
  store <n x 16 x i8> %data3, <n x 16 x i8> *%dest3

  %src4 = getelementptr <n x 16 x i8>, <n x 16 x i8> *%src, i64 -1
  %dest4 = getelementptr <n x 16 x i8>, <n x 16 x i8> *%dest, i64 -2
  %data4 = load <n x 16 x i8> , <n x 16 x i8> *%src4
  store <n x 16 x i8> %data4, <n x 16 x i8> *%dest4

  %dest5 = getelementptr <n x 16 x i8>, <n x 16 x i8> *%dest, i64 -3
  store <n x 16 x i8> %data4, <n x 16 x i8> *%dest5

  ret void
}

;; Base + scaled immediate offset failures due to forbidden expression (e.g. EC multipled by a runtime value)
define void @invalid_expressions(<n x 8 x i16> *%src, [ 100 x <n x 8 x i16> ] *%dest, i64 %n) {
; CHECK-LABEL: invalid_expressions:
; CHECK: cnth
  %somevalue = load <n x 8 x i16>, <n x 8 x i16>* %src
  %v0.addr = getelementptr [100 x <n x 8 x i16>], [ 100 x <n x 8 x i16> ]* %dest, i32 0, i64 %n
  store <n x 8 x i16> %somevalue, <n x 8 x i16>* %v0.addr

  ret void
}

; BASE COMPONENTS testing

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CASE A:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (add base1,
;      (add base2, ec))
;
; becomes:
;
; (add (add base1, base2) ec)
define void @caseA(<n x 8 x i16> *%src,  i64 %base1, <n x 8 x i16>* %base2) {
; CHECK-LABEL: caseA:
; CHECK-DAG: ld1h {[[Z:z[0-9]+]].h}, p{{[0-9]+}}/z, [x0]
; CHECK-DAG: lsl [[BASE1:x[0-9]+]], x1, #1
; CHECK-DAG: add [[BASE:x[0-9]+]], x2, [[BASE1]]
; CHECK-DAG: st1h {[[Z]].h}, p{{[0-9]+}}, {{\[}}[[BASE]], #1, mul vl]
; CHECK-NOT: rdvl
; CHECK-NOT: cnt
; CHECK-NOT: inc
  %somevalue = load <n x 8 x i16>, <n x 8 x i16>* %src
  %tmp = getelementptr <n x 8 x i16>, <n x 8 x i16> *  %base2, i64 1
  %tmp16 = bitcast <n x 8 x i16> * %tmp to i16*
  %tmp17 = getelementptr i16, i16*  %tmp16, i64 %base1
  %base =  bitcast i16* %tmp17 to <n x 8 x i16> *
  store <n x 8 x i16> %somevalue, <n x 8 x i16>* %base
  ret void
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CASE B:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (add offset,
;      (add base, (mul ec, k)))
;
; becomes:
;
; (add (add base, offset), (mul ec, k))
define void @caseB(<n x 8 x i16> *%src,  i64 %offset, <n x 8 x i16>* %base) {
; CHECK-LABEL: caseB:
; CHECK-DAG: ld1h {[[Z:z[0-9]+]].h}, p{{[0-9]+}}/z, [x0]
; CHECK-DAG: lsl [[OFFSET:x[0-9]+]], x1, #1
; CHECK-DAG: add [[BASE:x[0-9]+]], x2, [[OFFSET]]
; CHECK-DAG: st1h {[[Z]].h}, p{{[0-9]+}}, {{\[}}[[BASE]], #7, mul vl]
; CHECK-NOT: rdvl
; CHECK-NOT: cnt
; CHECK-NOT: inc
  %somevalue = load <n x 8 x i16>, <n x 8 x i16>* %src
  %tmp = getelementptr <n x 8 x i16>, <n x 8 x i16> *  %base, i64 7
  %tmp16 = bitcast <n x 8 x i16> * %tmp to i16*
  %tmp17 = getelementptr i16, i16*  %tmp16, i64 %offset
  %vbase =  bitcast i16* %tmp17 to <n x 8 x i16> *
  store <n x 8 x i16> %somevalue, <n x 8 x i16>* %vbase
  ret void
}

define void @caseBbis(<n x 8 x i16> *%src,  i64 %offset, <n x 8 x i16>* %base) {
; CHECK-LABEL: caseBbis:
; CHECK-DAG: ld1h {[[Z:z[0-9]+]].h}, p{{[0-9]+}}/z, [x0]
; CHECK-DAG: lsl [[OFFSET:x[0-9]+]], x1, #1
; CHECK-DAG: add [[BASE:x[0-9]+]], x2, [[OFFSET]]
; CHECK-DAG: st1h {[[Z]].h}, p{{[0-9]+}}, {{\[}}[[BASE]], #-7, mul vl]
; CHECK-NOT: rdvl
; CHECK-NOT: cnt
; CHECK-NOT: inc
  %somevalue = load <n x 8 x i16>, <n x 8 x i16>* %src
  %tmp = getelementptr <n x 8 x i16>, <n x 8 x i16> *  %base, i64 -7
  %tmp16 = bitcast <n x 8 x i16> * %tmp to i16*
  %tmp17 = getelementptr i16, i16*  %tmp16, i64 %offset
  %vbase =  bitcast i16* %tmp17 to <n x 8 x i16> *
  store <n x 8 x i16> %somevalue, <n x 8 x i16>* %vbase
  ret void
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CASE C (not valid transformation because EC multiple is not
; a compile time constant
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define void @caseC(<n x 8 x i16> *%src,  i64 %offset, <n x 8 x i16>* %base, i64 %k) {
; CHECK-LABEL: caseC:
; CHECK: cnth
; CHECK: st1h {z{{[0-9]+}}.h}, p{{[0-9]+}}, [x{{[0-9]+}}, x{{[0-9]+}}, lsl #1]
  %somevalue = load <n x 8 x i16>, <n x 8 x i16>* %src
  %tmp = getelementptr <n x 8 x i16>, <n x 8 x i16> *  %base, i64 %k
  %tmp16 = bitcast <n x 8 x i16> * %tmp to i16*
  %tmp17 = getelementptr i16, i16*  %tmp16, i64 %offset
  %vbase =  bitcast i16* %tmp17 to <n x 8 x i16> *
  store <n x 8 x i16> %somevalue, <n x 8 x i16>* %vbase
  ret void
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; CASE E (address subtraction)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (sub (add (mul ec, k), base),
;      offset)
;
; becomes:
;
; (add (mul ec, k),
;      (sub base, offset))

define void @caseE(<n x 8 x i16> *%src,  i64 %offset, <n x 8 x i16>* %base) {
; CHECK-LABEL: caseE:
; CHECK-DAG: ld1h {[[Z:z[0-9]+]].h}, p{{[0-9]+}}/z, [x0]
; CHECK-DAG: lsl [[OFFSET:x[0-9]+]], x1, #1
; CHECK-DAG: sub [[BASE:x[0-9]+]], x2, [[OFFSET]]
; CHECK-DAG: st1h {[[Z]].h}, p{{[0-9]+}}, {{\[}}[[BASE]], #-1, mul vl]
; CHECK-NOT: rdvl
; CHECK-NOT: cnt
; CHECK-NOT: inc
  %somevalue = load <n x 8 x i16>, <n x 8 x i16>* %src
  %tmp = getelementptr <n x 8 x i16>, <n x 8 x i16> *  %base, i64 -1
  %tmp16 = bitcast <n x 8 x i16> * %tmp to i16*
  %xxx = sub i64 0, %offset
  %tmp17 = getelementptr i16, i16*  %tmp16, i64 %xxx
  %vbase =  bitcast i16* %tmp17 to <n x 8 x i16> *
  store <n x 8 x i16> %somevalue, <n x 8 x i16>* %vbase
  ret void
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; complex computation
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (add base,
;      (add (mul ec, 7),
;           (shl (mul offset, 8), 1)))
;
; becomes:
;
; (add (add base,
;           (shl (mul offset, 8), 1)),
;      (mul ec, 7))
define void @complexexpr(<n x 16 x i8> *%src,  i64 %offset, <n x 16 x i8> * %base) {
; CHECK-LABEL: complexexpr:
; CHECK-DAG: ld1b {[[Z:z[0-9]+]].b}, p{{[0-9]+}}/z, [x0]
; CHECK-DAG: lsl [[SHL:x[0-8]+]], x1, #4
; CHECK-DAG: add  [[VBASE:x[0-8]+]], x2, [[SHL]]
; CHECK-DAG: st1b {[[Z]].b}, p{{[0-9]+}}, {{\[}}[[VBASE]], #7, mul vl]
; CHECK-NOT: rdvl
; CHECK-NOT: cnt
; CHECK-NOT: inc
  %somevalue = load <n x 16 x i8>, <n x 16 x i8>* %src
  %muloff = mul i64 %offset, 8
  %shl = shl i64 %muloff, 1
  %addr = getelementptr <n x 16 x i8>, <n x 16 x i8>* %base, i64 7
  %addr2 = bitcast <n x 16 x i8> * %addr to i8*
  %addr3 =  getelementptr i8, i8* %addr2, i64 %shl
  %vaddr = bitcast i8* %addr3 to <n x 16 x i8> *
  store <n x 16 x i8> %somevalue, <n x 16 x i8>* %vaddr
  ret void
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; (add (add (add BASE, (shl (sign_extend OFFSET) 3)),
;           (shl (srl EC, 3) 3)),
;       8)
;
; becomes:
;
; (add (add (add BASE, (shl (sign_extend OFFSET) 3)),
;       8),
;       (shl (srl EC, 3) 3))
define void @complexexpr2(<n x 16 x i8> *%src,  i32 %offset, i8 *%base) {
; CHECK-LABEL: complexexpr2:
; CHECK-DAG: ld1b {[[Z:z[0-9]+]].b}, p{{[0-9]+}}/z, [x0]
; CHECK-DAG: add [[BPO:x[0-9]+]], x2, w1, sxtw #3
; CHECK-DAG: orr w[[REGNUM:[0-9]+]], wzr, #0x8
; CHECK-DAG: add  [[VBASE:x[0-8]+]], [[BPO]], x[[REGNUM]]
; CHECK-DAG: st1b {[[Z]].b}, p{{[0-9]+}}, {{\[}}[[VBASE]], #1, mul vl]
; CHECK-NOT: rdvl
; CHECK-NOT: cnt
; CHECK-NOT: inc
  %somevalue = load <n x 16 x i8>, <n x 16 x i8>* %src
  %so = sext i32 %offset to i64
  %so1= shl i64 %so, 3
  %base1 = getelementptr i8, i8* %base, i64 %so1
  %base2 = getelementptr i8, i8* %base1, i8 8
  %base3 = bitcast i8* %base2 to <n x 16 x i8> *
  %base4 = getelementptr<n x 16 x i8>, <n x 16 x i8> * %base3, i64 1
  store <n x 16 x i8> %somevalue, <n x 16 x i8>* %base4
  ret void
}

;; Masked Loads & Stores - nx2xT

declare <n x 2 x i8> @llvm.masked.load.nxv2i8(<n x 2 x i8>*, i32, <n x 2 x i1>, <n x 2 x i8>)
declare <n x 2 x i16> @llvm.masked.load.nxv2i16(<n x 2 x i16>*, i32, <n x 2 x i1>, <n x 2 x i16>)
declare <n x 2 x i32> @llvm.masked.load.nxv2i32(<n x 2 x i32>*, i32, <n x 2 x i1>, <n x 2 x i32>)
declare <n x 2 x i64> @llvm.masked.load.nxv2i64(<n x 2 x i64>*, i32, <n x 2 x i1>, <n x 2 x i64>)
declare <n x 2 x float> @llvm.masked.load.nxv2f32(<n x 2 x float>*, i32, <n x 2 x i1>, <n x 2 x float>)
declare <n x 2 x double> @llvm.masked.load.nxv2f64(<n x 2 x double>*, i32, <n x 2 x i1>, <n x 2 x double>)

declare void @llvm.masked.store.nxv2i8(<n x 2 x i8>, <n x 2 x i8>*,  i32, <n x 2 x i1>)
declare void @llvm.masked.store.nxv2i16(<n x 2 x i16>, <n x 2 x i16>*, i32, <n x 2 x i1>)
declare void @llvm.masked.store.nxv2i32(<n x 2 x i32>, <n x 2 x i32>*, i32, <n x 2 x i1>)
declare void @llvm.masked.store.nxv2i64(<n x 2 x i64>, <n x 2 x i64>*, i32, <n x 2 x i1>)
declare void @llvm.masked.store.nxv2f32(<n x 2 x float>, <n x 2 x float>*, i32, <n x 2 x i1>)
declare void @llvm.masked.store.nxv2f64(<n x 2 x double>, <n x 2 x double>*, i32, <n x 2 x i1>)

define void @test_masked_ldst_nxv2i8(<n x 2 x i8> * %base) {
; CHECK-LABEL: test_masked_ldst_nxv2i8
; CHECK: ld1sb {z[[DATA:[0-9]+]].d}, p[[PRED:[0-9]+]]/z, [x0, #4, mul vl]
; CHECK: st1b {z[[DATA]].d}, p[[PRED]], [x0, #-3, mul vl]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %base_load = getelementptr <n x 2 x i8>,  <n x 2 x i8> * %base, i64 32
  %data = call <n x 2 x i8> @llvm.masked.load.nxv2i8(<n x 2 x i8> * %base_load, i32 1, <n x 2 x i1> %mask, <n x 2 x i8> undef) 
  %base_store = getelementptr <n x 2 x i8>,  <n x 2 x i8> * %base, i64 -24
  call void @llvm.masked.store.nxv2i8(<n x 2 x i8> %data, <n x 2 x i8>* %base_store,  i32 1, <n x 2 x i1> %mask)
  ret void
}

define void @test_masked_ldst_nxv2i16(<n x 2 x i16> * %base) {
; CHECK-LABEL: test_masked_ldst_nxv2i16
; CHECK: ld1sh {z[[DATA:[0-9]+]].d}, p[[PRED:[0-9]+]]/z, [x0, #4, mul vl]
; CHECK: st1h {z[[DATA]].d}, p[[PRED]], [x0, #-3, mul vl]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %base_load = getelementptr <n x 2 x i16>,  <n x 2 x i16> * %base, i64 16
  %data = call <n x 2 x i16> @llvm.masked.load.nxv2i16(<n x 2 x i16> * %base_load, i32 1, <n x 2 x i1> %mask, <n x 2 x i16> undef) 
  %base_store = getelementptr <n x 2 x i16>,  <n x 2 x i16> * %base, i64 -12
  call void @llvm.masked.store.nxv2i16(<n x 2 x i16> %data, <n x 2 x i16>* %base_store,  i32 1, <n x 2 x i1> %mask)
  ret void
}

define void @test_masked_ldst_nxv2i32(<n x 2 x i32> * %base) {
; CHECK-LABEL: test_masked_ldst_nxv2i32
; CHECK: ld1sw {z[[DATA:[0-9]+]].d}, p[[PRED:[0-9]+]]/z, [x0, #4, mul vl]
; CHECK: st1w {z[[DATA]].d}, p[[PRED]], [x0, #-3, mul vl]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %base_load = getelementptr <n x 2 x i32>,  <n x 2 x i32> * %base, i64 8
  %data = call <n x 2 x i32> @llvm.masked.load.nxv2i32(<n x 2 x i32> * %base_load, i32 1, <n x 2 x i1> %mask, <n x 2 x i32> undef) 
  %base_store = getelementptr <n x 2 x i32>,  <n x 2 x i32> * %base, i64 -6
  call void @llvm.masked.store.nxv2i32(<n x 2 x i32> %data, <n x 2 x i32>* %base_store,  i32 1, <n x 2 x i1> %mask)
  ret void
}

define void @test_masked_ldst_nxv2i64(<n x 2 x i64> * %base) {
; CHECK-LABEL: test_masked_ldst_nxv2i64
; CHECK: ld1d {z[[DATA:[0-9]+]].d}, p[[PRED:[0-9]+]]/z, [x0, #4, mul vl]
; CHECK: st1d {z[[DATA]].d}, p[[PRED]], [x0, #-3, mul vl]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %base_load = getelementptr <n x 2 x i64>,  <n x 2 x i64> * %base, i64 4
  %data = call <n x 2 x i64> @llvm.masked.load.nxv2i64(<n x 2 x i64> * %base_load, i32 1, <n x 2 x i1> %mask, <n x 2 x i64> undef) 
  %base_store = getelementptr <n x 2 x i64>,  <n x 2 x i64> * %base, i64 -3
  call void @llvm.masked.store.nxv2i64(<n x 2 x i64> %data, <n x 2 x i64>* %base_store,  i32 1, <n x 2 x i1> %mask)
  ret void
}

define void @test_masked_ldst_nxv2f32(<n x 2 x float> * %base) {
; CHECK-LABEL: test_masked_ldst_nxv2f32
; CHECK: ld1w {z[[DATA:[0-9]+]].d}, p[[PRED:[0-9]+]]/z, [x0, #4, mul vl]
; CHECK: st1w {z[[DATA]].d}, p[[PRED]], [x0, #-3, mul vl]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %base_load = getelementptr <n x 2 x float>,  <n x 2 x float> * %base, i64 8
  %data = call <n x 2 x float> @llvm.masked.load.nxv2f32(<n x 2 x float> * %base_load, i32 1, <n x 2 x i1> %mask, <n x 2 x float> undef) 
  %base_store = getelementptr <n x 2 x float>,  <n x 2 x float> * %base, i64 -6
  call void @llvm.masked.store.nxv2f32(<n x 2 x float> %data, <n x 2 x float>* %base_store,  i32 1, <n x 2 x i1> %mask)
  ret void
}

define void @test_masked_ldst_nxv2f64(<n x 2 x double> * %base) {
; CHECK-LABEL: test_masked_ldst_nxv2f64
; CHECK: ld1d {z[[DATA:[0-9]+]].d}, p[[PRED:[0-9]+]]/z, [x0, #7, mul vl]
; CHECK: st1d {z[[DATA]].d}, p[[PRED]], [x0, #-6, mul vl]
; CHECK: ret
  %bit = insertelement <n x 2 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 2 x i1> %bit, <n x 2 x i1> undef, <n x 2 x i32> zeroinitializer

  %base_load = getelementptr <n x 2 x double>,  <n x 2 x double> * %base, i64 7
  %data = call <n x 2 x double> @llvm.masked.load.nxv2f64(<n x 2 x double> * %base_load, i32 1, <n x 2 x i1> %mask, <n x 2 x double> undef) 
  %base_store = getelementptr <n x 2 x double>,  <n x 2 x double> * %base, i64 -6
  call void @llvm.masked.store.nxv2f64(<n x 2 x double> %data, <n x 2 x double>* %base_store,  i32 1, <n x 2 x i1> %mask)
  ret void
}

;; Masked Loads & Stores - nx4xT

declare <n x 4 x i8> @llvm.masked.load.nxv4i8(<n x 4 x i8>*, i32, <n x 4 x i1>, <n x 4 x i8>)
declare <n x 4 x i16> @llvm.masked.load.nxv4i16(<n x 4 x i16>*, i32, <n x 4 x i1>, <n x 4 x i16>)
declare <n x 4 x i32> @llvm.masked.load.nxv4i32(<n x 4 x i32>*, i32, <n x 4 x i1>, <n x 4 x i32>)
declare <n x 4 x float> @llvm.masked.load.nxv4f32(<n x 4 x float>*, i32, <n x 4 x i1>, <n x 4 x float>)

declare void @llvm.masked.store.nxv4i8(<n x 4 x i8>, <n x 4 x i8>*, i32, <n x 4 x i1>)
declare void @llvm.masked.store.nxv4i16(<n x 4 x i16>, <n x 4 x i16>*, i32, <n x 4 x i1>)
declare void @llvm.masked.store.nxv4i32(<n x 4 x i32>, <n x 4 x i32>*, i32, <n x 4 x i1>)
declare void @llvm.masked.store.nxv4f32(<n x 4 x float>, <n x 4 x float>*, i32, <n x 4 x i1>)

define void @test_masked_ldst_nxv4i8(<n x 4 x i8> * %base) {
; CHECK-LABEL: test_masked_ldst_nxv4i8
; CHECK: ld1sb {z[[DATA:[0-9]+]].s}, p[[PRED:[0-9]+]]/z, [x0, #4, mul vl]
; CHECK: st1b {z[[DATA]].s}, p[[PRED]], [x0, #-3, mul vl]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %base_load = getelementptr <n x 4 x i8>,  <n x 4 x i8> * %base, i64 16
  %data = call <n x 4 x i8> @llvm.masked.load.nxv4i8(<n x 4 x i8> * %base_load, i32 1, <n x 4 x i1> %mask, <n x 4 x i8> undef) 
  %base_store = getelementptr <n x 4 x i8>,  <n x 4 x i8> * %base, i64 -12
  call void @llvm.masked.store.nxv4i8(<n x 4 x i8> %data, <n x 4 x i8>* %base_store,  i32 1, <n x 4 x i1> %mask)
  ret void
}

define void @test_masked_ldst_nxv4i16(<n x 4 x i16> * %base) {
; CHECK-LABEL: test_masked_ldst_nxv4i16
; CHECK: ld1sh {z[[DATA:[0-9]+]].s}, p[[PRED:[0-9]+]]/z, [x0, #4, mul vl]
; CHECK: st1h {z[[DATA]].s}, p[[PRED]], [x0, #-3, mul vl]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %base_load = getelementptr <n x 4 x i16>,  <n x 4 x i16> * %base, i64 8
  %data = call <n x 4 x i16> @llvm.masked.load.nxv4i16(<n x 4 x i16> * %base_load, i32 1, <n x 4 x i1> %mask, <n x 4 x i16> undef) 
  %base_store = getelementptr <n x 4 x i16>,  <n x 4 x i16> * %base, i64 -6
  call void @llvm.masked.store.nxv4i16(<n x 4 x i16> %data, <n x 4 x i16>* %base_store,  i32 1, <n x 4 x i1> %mask)
  ret void
}

define void @test_masked_ldst_nxv4i32(<n x 4 x i32> * %base) {
; CHECK-LABEL: test_masked_ldst_nxv4i32
; CHECK: ld1w {z[[DATA:[0-9]+]].s}, p[[PRED:[0-9]+]]/z, [x0, #4, mul vl]
; CHECK: st1w {z[[DATA]].s}, p[[PRED]], [x0, #-3, mul vl]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %base_load = getelementptr <n x 4 x i32>,  <n x 4 x i32> * %base, i64 4
  %data = call <n x 4 x i32> @llvm.masked.load.nxv4i32(<n x 4 x i32> * %base_load, i32 1, <n x 4 x i1> %mask, <n x 4 x i32> undef) 
  %base_store = getelementptr <n x 4 x i32>,  <n x 4 x i32> * %base, i64 -3
  call void @llvm.masked.store.nxv4i32(<n x 4 x i32> %data, <n x 4 x i32>* %base_store,  i32 1, <n x 4 x i1> %mask)
  ret void
}

define void @test_masked_ldst_nxv4f32(<n x 4 x float> * %base) {
; CHECK-LABEL: test_masked_ldst_nxv4f32
; CHECK: ld1w {z[[DATA:[0-9]+]].s}, p[[PRED:[0-9]+]]/z, [x0, #4, mul vl]
; CHECK: st1w {z[[DATA]].s}, p[[PRED]], [x0, #-3, mul vl]
; CHECK: ret
  %bit = insertelement <n x 4 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 4 x i1> %bit, <n x 4 x i1> undef, <n x 4 x i32> zeroinitializer

  %base_load = getelementptr <n x 4 x float>,  <n x 4 x float> * %base, i64 4
  %data = call <n x 4 x float> @llvm.masked.load.nxv4f32(<n x 4 x float> * %base_load, i32 1, <n x 4 x i1> %mask, <n x 4 x float> undef) 
  %base_store = getelementptr <n x 4 x float>,  <n x 4 x float> * %base, i64 -3
  call void @llvm.masked.store.nxv4f32(<n x 4 x float> %data, <n x 4 x float>* %base_store,  i32 1, <n x 4 x i1> %mask)
  ret void
}

;; Masked Loads & Stores - nx8xT

declare <n x 8 x i8> @llvm.masked.load.nxv8i8(<n x 8 x i8>*, i32, <n x 8 x i1>, <n x 8 x i8>)
declare <n x 8 x i16> @llvm.masked.load.nxv8i16(<n x 8 x i16>*, i32, <n x 8 x i1>, <n x 8 x i16>)

declare void @llvm.masked.store.nxv8i8(<n x 8 x i8>, <n x 8 x i8>*, i32, <n x 8 x i1>)
declare void @llvm.masked.store.nxv8i16(<n x 8 x i16>, <n x 8 x i16>*, i32, <n x 8 x i1>)

define void @test_masked_ldst_nxv8i8(<n x 8 x i8> * %base) {
; CHECK-LABEL: test_masked_ldst_nxv8i8
; CHECK: ld1sb {z[[DATA:[0-9]+]].h}, p[[PRED:[0-9]+]]/z, [x0, #4, mul vl]
; CHECK: st1b {z[[DATA]].h}, p[[PRED]], [x0, #-3, mul vl]
; CHECK: ret
  %bit = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 8 x i1> %bit, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer

  %base_load = getelementptr <n x 8 x i8>,  <n x 8 x i8> * %base, i64 8
  %data = call <n x 8 x i8> @llvm.masked.load.nxv8i8(<n x 8 x i8> * %base_load, i32 1, <n x 8 x i1> %mask, <n x 8 x i8> undef) 
  %base_store = getelementptr <n x 8 x i8>,  <n x 8 x i8> * %base, i64 -6
  call void @llvm.masked.store.nxv8i8(<n x 8 x i8> %data, <n x 8 x i8>* %base_store,  i32 1, <n x 8 x i1> %mask)
  ret void
}

define void @test_masked_ldst_nxv8i16(<n x 8 x i16> * %base) {
; CHECK-LABEL: test_masked_ldst_nxv8i16
; CHECK: ld1h {z[[DATA:[0-9]+]].h}, p[[PRED:[0-9]+]]/z, [x0, #4, mul vl]
; CHECK: st1h {z[[DATA]].h}, p[[PRED]], [x0, #-3, mul vl]
; CHECK: ret
  %bit = insertelement <n x 8 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 8 x i1> %bit, <n x 8 x i1> undef, <n x 8 x i32> zeroinitializer

  %base_load = getelementptr <n x 8 x i16>,  <n x 8 x i16> * %base, i64 4
  %data = call <n x 8 x i16> @llvm.masked.load.nxv8i16(<n x 8 x i16> * %base_load, i32 1, <n x 8 x i1> %mask, <n x 8 x i16> undef) 
  %base_store = getelementptr <n x 8 x i16>,  <n x 8 x i16> * %base, i64 -3
  call void @llvm.masked.store.nxv8i16(<n x 8 x i16> %data, <n x 8 x i16>* %base_store,  i32 1, <n x 8 x i1> %mask)
  ret void
}

;; Masked Loads & Stores - nx16xT

declare <n x 16 x i8> @llvm.masked.load.nxv16i8(<n x 16 x i8>*, i32, <n x 16 x i1>, <n x 16 x i8>)
declare void @llvm.masked.store.nxv16i8(<n x 16 x i8>, <n x 16 x i8>*, i32, <n x 16 x i1>)

define void @test_masked_ldst_nxv16i8(<n x 16 x i8> * %base) {
; CHECK-LABEL: test_masked_ldst_nxv16i8
; CHECK: ld1b {z[[DATA:[0-9]+]].b}, p[[PRED:[0-9]+]]/z, [x0, #1, mul vl]
; CHECK: st1b {z[[DATA]].b}, p[[PRED]], [x0, #-1, mul vl]
; CHECK: ret
  %bit = insertelement <n x 16 x i1> undef, i1 1, i32 0
  %mask = shufflevector <n x 16 x i1> %bit, <n x 16 x i1> undef, <n x 16 x i32> zeroinitializer

  %base_load = getelementptr <n x 16 x i8>,  <n x 16 x i8> * %base, i64 1
  %data = call <n x 16 x i8> @llvm.masked.load.nxv16i8(<n x 16 x i8> * %base_load, i32 1, <n x 16 x i1> %mask, <n x 16 x i8> undef) 
  %base_store = getelementptr <n x 16 x i8>,  <n x 16 x i8> * %base, i64 -1
  call void @llvm.masked.store.nxv16i8(<n x 16 x i8> %data, <n x 16 x i8>* %base_store,  i32 1, <n x 16 x i1> %mask)
  ret void
}
