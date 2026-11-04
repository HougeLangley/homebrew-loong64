class Ruby < Formula
  desc "Object-oriented scripting language (system stub)"
  homepage "https://www.gnu.org/"
  url "file:///home/houge/infra/srv/stubs/ruby-4.0.9.tar.gz"
  sha256 "f84c26a4b5fe41e71b0e110e66ac95a6255e991e43a2875017a063bdad4f5809"
  version "4.0.9"

  def install
    bin.mkpath; lib.mkpath; include.mkpath; share.mkpath
    %w[ruby gem irb].each { |t| (bin/t).make_symlink "/usr/bin/#{t}" if File.exist?("/usr/bin/#{t}") }
    (lib/"ruby").mkpath
    cp_r Dir["/usr/lib/ruby/*"], lib/"ruby" if Dir.exist?("/usr/lib/ruby")
    cp_r Dir["/usr/include/ruby*/*"], include if Dir.exist?("/usr/include")
    a = Dir["#{include}/**/ruby/config.h"].first
    (include/"ruby/config.h").make_symlink(a) if a
    (prefix/"system_stub").write "provided by AOSC OS\n"
  end

  test do
    assert_predicate prefix/"system_stub", :exist?
  end
end
