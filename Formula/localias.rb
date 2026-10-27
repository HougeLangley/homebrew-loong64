class Localias < Formula
  desc "custom local domain aliases for local dev servers"
  homepage "https://example.org/localias"
  version "3.0.0+commit.43c3619"
  url "http://127.0.0.1:8080/brew/bottles/localias--3.0.0+commit.43c3619.loongarch64.bottle.tar.gz"
  sha256 "c40069b6206420a8d58915eb342cd6c0fd8d52843c104e66637d3f8a8322423e"

  def install
    bin.install "localias"
  end

  test do
    system "#{bin}/localias"
  end
end
