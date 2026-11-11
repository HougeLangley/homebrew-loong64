class GobjectIntrospection < Formula
  desc "GObject introspection tools (system stub)"
  homepage "https://gitlab.gnome.org/GNOME/gobject-introspection"
  url "file:///home/houge/infra/srv/stubs/gobject-introspection-1.86.0.tar.gz"
  sha256 "b2713708fd401048ab81d0099f379ef88aa0a75275ecc82fba8e19f584dfefe1"
  version "1.86.0"

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any, loongarch64_linux: "483216e6fee50eb2d26f46ac103a28607ebead80a4ef4a64bd8dc79fe0507cd9"
  end

  def install
    bin.mkpath; lib.mkpath; include.mkpath
    (include/"gobject-introspection-1.0").mkpath
    # g-ir-scanner 在 brew 环境里跑不起来，包一层：--version 直接返回，其余转发。
    # 系统扫描器是 `env python3` 脚本，其 _giscanner 扩展只 ABI 匹配系统 Python
    # （cpython-314）；brew 环境的 PATH 会把 brew Python（3.15）顶到前面导致
    # ModuleNotFoundError（at-spi2-core 实证）。因此转发时强制系统 PATH。
    (bin/"g-ir-scanner").write <<~SH
      #!/usr/bin/env bash
      if [[ "$1" == "--version" ]]; then echo "g-ir-scanner 1.86.0"; exit 0; fi
      exec env PATH=/usr/bin:/bin /usr/bin/g-ir-scanner.real "$@"
    SH
    chmod 0755, bin/"g-ir-scanner"
    (bin/"g-ir-compiler").make_symlink "/usr/bin/g-ir-compiler" if File.exist?("/usr/bin/g-ir-compiler")
    # meson 通过 pkg-config 找扫描器路径，必须指向我们包装过的那个
    (lib/"pkgconfig").mkpath
    (lib/"pkgconfig/gobject-introspection-1.0.pc").write <<~PC
      prefix=#{prefix}
      libdir=#{lib}
      includedir=#{include}
      Name: gobject-introspection
      Description: GObject Introspection
      Version: 1.86.0
      g_ir_scanner=#{bin}/g-ir-scanner
      g_ir_compiler=#{bin}/g-ir-compiler
      g_ir_generate=#{bin}/g-ir-generate
    PC
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate bin/"g-ir-scanner", :exist?
  end
end
