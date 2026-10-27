class Stackql < Formula
  desc "SQL interface for arbitrary resources with full CRUD support"
  homepage "https://example.org/stackql"
  version "0.12.824"
  url "http://127.0.0.1:8080/brew/bottles/stackql--0.12.824.loongarch64.bottle.tar.gz"
  sha256 "90224cc45d2ae238c06e337f47747e430de7c2893548ac2627ab9392dd6a6ae3"

  def install
    bin.install "stackql"
  end

  test do
    system "#{bin}/stackql"
  end
end
