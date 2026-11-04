class Libsepol < Formula
  desc "SELinux binary policy manipulation library"
  homepage "https://github.com/SELinuxProject/selinux"
  url "https://github.com/SELinuxProject/selinux/releases/download/3.11/libsepol-3.11.tar.gz"
  sha256 "79f3d2c88f44b7eb5cf54d9792e03232297e17f97a179163f2750099a00f164d"
  license "LGPL-2.1-or-later"

  livecheck do
    url :stable
    regex(/^libsepol[._-]v?(\d+(?:\.\d+)+)$/i)
  end


  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "e02961486194bcdf5a934be0021800a3eee60a85ff3749a0a461a3a2b4e807a1"
  end

  depends_on "rpm2cpio" => :test

  uses_from_macos "flex" => :build
  uses_from_macos "cpio" => :test

  on_macos do
    depends_on "coreutils" => :build # for GNU ln
  end

  resource "homebrew-example-policy", :test do
    url "https://web.archive.org/web/20250912032601/https://dl.fedoraproject.org/pub/fedora/linux/development/rawhide/Server/x86_64/os/Packages/s/selinux-policy-targeted-42.8-1.fc44.noarch.rpm"
    sha256 "f551899bec63f9496e4fda49db734a0dbd740c63537d3d4bf285cc5c742b8c2a"
  end

  def install
    system "make", "install", "PREFIX=#{prefix}", "SHLIBDIR=#{lib}"
  end

  test do
    resource("homebrew-example-policy").stage testpath

    pipe_output("cpio -idm", shell_output("rpm2cpio selinux-policy-targeted-42.8-1.fc44.noarch.rpm"))
    policy = "etc/selinux/targeted/policy/policy.35"
    context = "system_u:object_r:httpd_sys_content_t:s0"
    output = shell_output("#{bin}/chkcon #{policy} #{context}")
    assert_equal "#{context} is valid\n", output
  end
end
