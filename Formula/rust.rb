class Rust < Formula
  desc "Systems programming language (system stub)"
  homepage "https://www.gnu.org/"
  url "file:///home/houge/infra/srv/stubs/rust-1.99.1.tar.gz"
  sha256 "f84c26a4b5fe41e71b0e110e66ac95a6255e991e43a2875017a063bdad4f5809"
  version "1.99.1"

  def install
    bin.mkpath; lib.mkpath; include.mkpath; share.mkpath
    %w[rustc cargo rustdoc].each { |t| (bin/t).make_symlink "/usr/bin/#{t}" if File.exist?("/usr/bin/#{t}") }
    (lib/"rustlib").mkpath
    cp_r Dir["/usr/lib/rustlib/*"], lib/"rustlib" if Dir.exist?("/usr/lib/rustlib")
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
  end
end
