#!/usr/bin/env python3
"""
Homebrew LoongArch Build Automation Script
用于在 systemd-nspawn 容器中批量构建 Homebrew 包
"""

import subprocess
import sys
import time
import json
from datetime import datetime
from pathlib import Path

# 核心工具链包（按依赖顺序）
CORE_TOOLCHAIN = [
    "xz",
    "ca-certificates",
    "ncurses",
    "pkgconf",
    "zlib-ng-compat",
    "lz4",
    "zstd",
    "openssl@3",
    "cmake",
    "ninja",
    "meson",
    "autoconf",
    "automake",
    "libtool",
    "m4",
    "gettext",
    "libffi",
    "libtasn1",
    "nettle",
    "p11-kit",
    "gmp",
    "mpfr",
    "libmpc",
    "isl",
    "gcc",
]

# 常用开发工具
DEV_TOOLS = [
    "git",
    "curl",
    "wget",
    "jq",
    "yq",
    "ripgrep",
    "fd",
    "bat",
    "exa",
    "htop",
    "tree",
    "tmux",
    "vim",
    "neovim",
    "python@3.13",
    "node",
    "rust",
]

# 其他常用工具
COMMON_TOOLS = [
    "sqlite",
    "readline",
    "libpng",
    "libjpeg-turbo",
    "libtiff",
    "freetype",
    "fontconfig",
    "pixman",
    "cairo",
    "pango",
    "libxml2",
    "libxslt",
    "libyaml",
    "gdbm",
    "berkeley-db",
    "lzo",
    "libevent",
    "libuv",
    "libidn2",
    "libssh2",
    "nghttp2",
    "libunistring",
]


class HomebrewBuilder:
    def __init__(self, container_path="/var/lib/machines/homebrew-build"):
        self.container_path = container_path
        self.results = []
        self.start_time = None

    def run_in_container(self, command, user="brewbuilder", timeout=600):
        """在 nspawn 容器中运行命令"""
        env_vars = (
            "export CI=1 "
            "DEBIAN_FRONTEND=noninteractive "
            "HOMEBREW_NO_AUTO_UPDATE=1 "
            "HOMEBREW_NO_ENV_HINTS=1 "
            "HOMEBREW_NO_INSTALL_CLEANUP=1 "
            "HOMEBREW_DEVELOPER=1 "
            "HOMEBREW_USE_RUBY_FROM_PATH=1 "
            "HOMEBREW_NO_INSTALL_FROM_API=1 "
            "PATH=/home/brew-build/brew/bin:/home/brew-build/brew/sbin:$PATH; "
        )

        full_command = f"{env_vars}{command}"

        cmd = [
            "sudo",
            "systemd-nspawn",
            "-D",
            self.container_path,
            "--pipe",
            "--user",
            user,
            "--",
            "/bin/bash",
            "-c",
            full_command,
        ]

        try:
            result = subprocess.run(
                cmd, capture_output=True, text=True, timeout=timeout
            )
            return result.returncode, result.stdout, result.stderr
        except subprocess.TimeoutExpired:
            return -1, "", "Timeout"

    def build_package(self, formula, timeout=600):
        """构建单个包"""
        print(f"\n[BUILD] {formula} ...", flush=True)
        self.start_time = time.time()

        returncode, stdout, stderr = self.run_in_container(
            f"brew install --build-from-source {formula} 2>&1", timeout=timeout
        )

        elapsed = time.time() - self.start_time

        result = {
            "formula": formula,
            "success": returncode == 0,
            "returncode": returncode,
            "elapsed": round(elapsed, 2),
            "stdout": stdout[-2000:] if len(stdout) > 2000 else stdout,
            "stderr": stderr[-500:] if len(stderr) > 500 else stderr,
        }

        if result["success"]:
            print(f"  ✓ Success ({elapsed:.1f}s)")
        else:
            print(f"  ✗ Failed (code={returncode}, {elapsed:.1f}s)")

        self.results.append(result)
        return result["success"]

    def check_installed(self, formula):
        """检查包是否已安装"""
        returncode, stdout, _ = self.run_in_container(
            f"brew list {formula} 2>&1", timeout=30
        )
        return returncode == 0

    def build_packages(self, packages, skip_installed=True):
        """批量构建包"""
        print(f"\n{'=' * 60}")
        print(f"Starting batch build: {len(packages)} packages")
        print(f"{'=' * 60}")

        success_count = 0
        fail_count = 0
        skip_count = 0

        for formula in packages:
            if skip_installed and self.check_installed(formula):
                print(f"\n[SKIP] {formula} (already installed)")
                skip_count += 1
                continue

            if self.build_package(formula):
                success_count += 1
            else:
                fail_count += 1
                # 失败后继续构建其他包

        self.print_summary(success_count, fail_count, skip_count)
        return success_count, fail_count, skip_count

    def print_summary(self, success, fail, skip):
        """打印构建摘要"""
        print(f"\n{'=' * 60}")
        print("BUILD SUMMARY")
        print(f"{'=' * 60}")
        print(f"Success:  {success}")
        print(f"Failed:   {fail}")
        print(f"Skipped:  {skip}")
        print(f"Total:    {success + fail + skip}")

        if fail > 0:
            print(f"\nFailed packages:")
            for r in self.results:
                if not r["success"]:
                    print(f"  - {r['formula']}")

    def save_report(self, filename="build-report.json"):
        """保存详细报告"""
        report = {
            "timestamp": datetime.now().isoformat(),
            "container": self.container_path,
            "results": self.results,
            "summary": {
                "success": sum(1 for r in self.results if r["success"]),
                "failed": sum(1 for r in self.results if not r["success"]),
            },
        }

        with open(filename, "w") as f:
            json.dump(report, f, indent=2)

        print(f"\nReport saved to: {filename}")


def main():
    import argparse

    parser = argparse.ArgumentParser(description="Homebrew LoongArch Build Automation")
    parser.add_argument(
        "--packages",
        "-p",
        choices=["core", "dev", "common", "all"],
        default="core",
        help="Package set to build",
    )
    parser.add_argument("--formula", "-f", help="Build specific formula")
    parser.add_argument(
        "--container",
        "-c",
        default="/var/lib/machines/homebrew-build",
        help="Container path",
    )
    parser.add_argument(
        "--timeout", "-t", type=int, default=600, help="Build timeout in seconds"
    )
    parser.add_argument("--report", "-r", help="Save report to JSON file")

    args = parser.parse_args()

    builder = HomebrewBuilder(args.container)

    if args.formula:
        # 构建指定包
        builder.build_package(args.formula, timeout=args.timeout)
    else:
        # 批量构建
        if args.packages == "core":
            packages = CORE_TOOLCHAIN
        elif args.packages == "dev":
            packages = DEV_TOOLS
        elif args.packages == "common":
            packages = COMMON_TOOLS
        else:  # all
            packages = CORE_TOOLCHAIN + DEV_TOOLS + COMMON_TOOLS

        builder.build_packages(packages)

    if args.report:
        builder.save_report(args.report)


if __name__ == "__main__":
    main()
