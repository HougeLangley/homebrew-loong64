class Hishtory < Formula
  desc "Your shell history: synced, queryable, and in context"
  homepage "https://example.org/hishtory"
  version "0.335"
  url "http://127.0.0.1:8080/brew/bottles/hishtory--0.335.loongarch64.bottle.tar.gz"
  sha256 "14373e66b39bb87f370f5ed8038b3d93bc94a512918805f54359ba134b8019a9"

  def install
    bin.install "hishtory"
  end

  test do
    system "#{bin}/hishtory"
  end
end
