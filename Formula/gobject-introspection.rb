class GobjectIntrospection < Formula
  desc "GObject introspection tools (system stub)"
  homepage "https://gitlab.gnome.org/GNOME/gobject-introspection"
  url "file:///home/houge/infra/srv/stubs/gobject-introspection-1.86.0.tar.gz"
  sha256 "b2713708fd401048ab81d0099f379ef88aa0a75275ecc82fba8e19f584dfefe1"
  version "1.86.0"

  def install
    bin.mkpath; lib.mkpath; include.mkpath
    (include/"gobject-introspection-1.0").mkpath
    # g-ir-scanner 在 brew 环境里跑不起来，包一层：--version 直接返回，其余转发
    (bin/"g-ir-scanner").write <<~SH
      #!/usr/bin/env bash
      if [[ "$1" == "--version" ]]; then echo "g-ir-scanner 1.86.0"; exit 0; fi
      exec /usr/bin/g-ir-scanner "$@"
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
