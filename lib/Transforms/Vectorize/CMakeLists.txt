add_llvm_library(LLVMVectorize
  BBVectorize.cpp
  Vectorize.cpp
  LoopVectorizationAnalysis.cpp
  LoopVectorize.cpp
  SearchLoopVectorize.cpp
  SLPVectorizer.cpp
  BOSCC.cpp

  ADDITIONAL_HEADER_DIRS
  ${LLVM_MAIN_INCLUDE_DIR}/llvm/Transforms
  ${LLVM_MAIN_INCLUDE_DIR}/llvm/Transforms/IPO
  )

add_dependencies(LLVMVectorize intrinsics_gen)
