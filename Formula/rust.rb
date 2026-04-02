class Rust < Formula
  desc "Safe, concurrent, practical language"
  homepage "https://www.rust-lang.org/"
  url "https://static.rust-lang.org/dist/rustc-1.94.1-src.tar.gz"
  sha256 "7e31892b17224ccd6663c45eb0c82e1d3f5d0cfd4e9f37c21955a773b61fa1e6"
  license any_of: ["Apache-2.0", "MIT"]

  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "python@3.14" => :build
  depends_on "libgit2"
  depends_on "libssh2"
  depends_on "llvm"
  depends_on "pkgconf"

  resource "cargo" do
    url "https://github.com/rust-lang/cargo/archive/refs/tags/0.86.0.tar.gz"
    sha256 "2d4c573d6b0419657dd635389ed9fd9ef93c88d9a38b4d8e9f9984f1aefd6fe5"
  end

  def install
    ENV.prepend_path "PATH", Formula["python@3.14"].opt_libexec/"bin"

    # Fix for LoongArch
    ENV["RUSTFLAGS"] = "-C linker=gcc"

    args = %W[
      --prefix=#{prefix}
      --enable-vendor
      --disable-docs
      --tools=cargo
      --llvm-root=#{Formula["llvm"].opt_prefix}
      --disable-codegen-tests
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/rustc", "--version"
    system "#{bin}/cargo", "--version"
  end
end
