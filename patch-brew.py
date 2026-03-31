#!/usr/bin/env python3
"""Patch Homebrew/brew for LoongArch (loong64) architecture support."""

import os

BREW = os.path.expanduser("~/homebrew-build/brew")


def patch_file(relpath, patches):
    """Apply a list of (old, new) replacements to a file."""
    path = os.path.join(BREW, relpath)
    with open(path, "r") as f:
        content = f.read()
    for old, new in patches:
        if old not in content:
            print(f"  WARNING: pattern not found in {relpath}:")
            print(f"    {old[:80]}...")
            continue
        content = content.replace(old, new)
    with open(path, "w") as f:
        f.write(content)
    print(f"  {relpath}: OK")


# ============================================================
# Patch 1: brew.sh - add loongarch64 MACHTYPE case
# ============================================================
patch_file(
    "Library/Homebrew/brew.sh",
    [
        (
            '  x86_64-*)\n    HOMEBREW_PROCESSOR="x86_64"\n    ;;\n  *)',
            '  x86_64-*)\n    HOMEBREW_PROCESSOR="x86_64"\n    ;;\n  loongarch64-*)\n    HOMEBREW_PROCESSOR="loong64"\n    ;;\n  *)',
        ),
    ],
)

# ============================================================
# Patch 2: hardware.rb - add LoongArch architecture support
# ============================================================
patch_file(
    "Library/Homebrew/hardware.rb",
    [
        # 2a: Add LOONGARCH constants
        (
            "ARM_ARCHS         = ARM_64BIT_ARCHS",
            "LOONGARCH_64BIT_ARCHS = [:loong64, :loongarch64].freeze\n    LOONGARCH_ARCHS       = LOONGARCH_64BIT_ARCHS\n    ARM_ARCHS         = ARM_64BIT_ARCHS",
        ),
        # 2b: Add LOONGARCH_ARCHS to ALL_ARCHS
        (
            "*ARM_ARCHS,\n].freeze",
            "*ARM_ARCHS,\n      *LOONGARCH_ARCHS,\n].freeze",
        ),
        # 2c: Add loongarch to CPU type detection
        (
            "when /ppc|powerpc/ then :ppc",
            "when /loongarch/ then :loongarch\n        when /ppc|powerpc/ then :ppc",
        ),
        # 2d: Add loongarch to bits detection (64-bit only for now)
        (
            "when /x86_64/, /ppc64|powerpc64/, /aarch64|arm64/ then 64",
            "when /x86_64/, /ppc64|powerpc64/, /aarch64|arm64/, /loongarch64/ then 64",
        ),
        # 2e: Add loongarch? and loong64? methods before arm? method comment
        (
            "      # Check whether the CPU architecture is ARM.",
            (
                "      # Check whether the CPU architecture is LoongArch.\n"
                "      #\n"
                "      # @api internal\n"
                "      sig { returns(T::Boolean) }\n"
                "      def loongarch?\n"
                "        type == :loongarch\n"
                "      end\n"
                "\n"
                "      # Check whether the CPU architecture is 64-bit LoongArch.\n"
                "      sig { returns(T::Boolean) }\n"
                "      def loong64?\n"
                "        loongarch? && is_64_bit?\n"
                "      end\n"
                "\n"
                "      # Check whether the CPU architecture is ARM."
            ),
        ),
        # 2f: Add loong64 to arch_64_bit method
        (
            "        elsif ppc64le?\n          :ppc64le",
            "        elsif loong64?\n          :loong64\n        elsif ppc64le?\n          :ppc64le",
        ),
    ],
)

# ============================================================
# Patch 3: bottles.rb - add loong64 to standardized_arch
# ============================================================
patch_file(
    "Library/Homebrew/utils/bottles.rb",
    [
        (
            "return :arm64 if [:arm64, :arm, :aarch64].include? arch",
            "return :arm64 if [:arm64, :arm, :aarch64].include? arch\n        return :loong64 if [:loong64, :loongarch64].include? arch",
        ),
    ],
)

# ============================================================
# Patch 4: arch_requirement.rb - add loong64 satisfaction
# ============================================================
patch_file(
    "Library/Homebrew/requirements/arch_requirement.rb",
    [
        (
            "when :arm, :intel, :ppc then Hardware::CPU.type == @arch",
            "when :loong64 then Hardware::CPU.loong64?\n    when :arm, :intel, :ppc then Hardware::CPU.type == @arch",
        ),
    ],
)

# ============================================================
# Patch 5: linux/cpu.rb - add loongarch family detection
# ============================================================
patch_file(
    "Library/Homebrew/extend/os/linux/hardware/cpu.rb",
    [
        (
            "return :arm if arm?\n            return :ppc if ppc?\n            return :dunno unless intel?",
            "return :arm if arm?\n            return :loongarch if loongarch?\n            return :ppc if ppc?\n            return :dunno unless intel?",
        ),
    ],
)

print("\n=== All patches applied ===")
