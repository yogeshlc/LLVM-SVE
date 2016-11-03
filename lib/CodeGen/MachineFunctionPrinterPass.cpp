//===-- MachineFunctionPrinterPass.cpp ------------------------------------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// MachineFunctionPrinterPass implementation.
//
//===----------------------------------------------------------------------===//

#include "llvm/CodeGen/Passes.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/SlotIndexes.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
/// MachineFunctionPrinterPass - This is a pass to dump the IR of a
/// MachineFunction.
///
struct MachineFunctionPrinterPass : public MachineFunctionPass {
  static char ID;

  raw_ostream &OS;
  const std::string Banner;

  MachineFunctionPrinterPass() : MachineFunctionPass(ID), OS(dbgs()) { }
  MachineFunctionPrinterPass(raw_ostream &os, const std::string &banner)
      : MachineFunctionPass(ID), OS(os), Banner(banner) {}

  const char *getPassName() const override { return "MachineFunction Printer"; }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.setPreservesAll();
    MachineFunctionPass::getAnalysisUsage(AU);
  }

  bool runOnMachineFunction(MachineFunction &MF) override {
    if (!llvm::isFunctionInPrintList(MF.getName()))
      return false;
    OS << "# " << Banner << ":\n";
    MF.print(OS, getAnalysisIfAvailable<SlotIndexes>());
    return false;
  }
};

char MachineFunctionPrinterPass::ID = 0;

class MachineFunctionBlamePass : public MachineFunctionPass {
  const std::string PassName;

public:
  static char ID;
  MachineFunctionBlamePass() : MachineFunctionPass(ID) {}
  MachineFunctionBlamePass(const std::string &PassName)
    : MachineFunctionPass(ID), PassName(PassName) {}

  const char *getPassName() const override { return "MachineFunction Blamer"; }

  void getAnalysisUsage(AnalysisUsage &AU) const override {
    AU.setPreservesAll();
    MachineFunctionPass::getAnalysisUsage(AU);
  }

  bool runOnMachineFunction(MachineFunction &MF) override {
    // TODO: When we update to a newer community base, we may
    // wish to implement this properly to tag machine IR. In
    // the current codebase we can't do this, so just warn
    // if anyone tries to perform codegen with blaming.
    errs() << "Would blame machine function pass\n";
    return false;
  }
};

char MachineFunctionBlamePass::ID = 0;
}

char &llvm::MachineFunctionPrinterPassID = MachineFunctionPrinterPass::ID;
INITIALIZE_PASS(MachineFunctionPrinterPass, "machineinstr-printer",
                "Machine Function Printer", false, false)

namespace llvm {
/// Returns a newly-created MachineFunction Printer pass. The
/// default banner is empty.
///
MachineFunctionPass *createMachineFunctionPrinterPass(raw_ostream &OS,
                                                      const std::string &Banner){
  return new MachineFunctionPrinterPass(OS, Banner);
}

MachineFunctionPass *createMachineFunctionBlamePass(const std::string &PassName){
  return new MachineFunctionBlamePass(PassName);
}

}
