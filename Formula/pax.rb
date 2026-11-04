class Pax < Formula
  desc "Portable Archive Interchange archive tool"
  homepage "https://mbsd.evolvis.org/pax.htm"
  url "https://mbsd.evolvis.org/MirOS/dist/mir/cpio/paxmirabilis-20240817.tgz"
  sha256 "e955d5d3af97aede0a3f463a9a59b83e8d1083aaf142eb6f388c549a7d182e6b"
  license "MirOS"

  livecheck do
    url "https://mbsd.evolvis.org/MirOS/dist/mir/cpio"
    regex(/href=.*?paxmirabilis[._-]v?(\d+(?:\.\d+)*)\.t/i)
  end


  keg_only :provided_by_macos

  bottle do
    root_url "https://homebrewloongarch64.site/brew-bottles"
    sha256 cellar: :any_skip_relocation, loongarch64_linux: "f7230ddd91b6a5d288dab047e5a3dd5ef06427a599c12e2e2d5777388bb35116"
  end

  def install
    mkdir "build" do
      system "sh", "../Build.sh", "-r", "-tpax"
      bin.install "pax"
    end
  end

  test do
    (testpath/"foo").write "test"
    system bin/"pax", "-f", testpath/"foo.pax", "-w", testpath/"foo"
    rm testpath/"foo"
    system bin/"pax", "-f", testpath/"foo.pax", "-r"
    assert_path_exists testpath/"foo"
  end
end
