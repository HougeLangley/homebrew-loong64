class Docker-credential-helper-ecr < Formula
  desc "Docker Credential Helper for Amazon ECR"
  homepage "https://example.org/docker-credential-helper-ecr"
  version "0.12.0"
  url "http://127.0.0.1:8080/brew/bottles/docker-credential-helper-ecr--0.12.0.loongarch64.bottle.tar.gz"
  sha256 "8e1d0f5eb663eb5f44466a2993b39b9678762de3943bcb569df4e03115a609e5"

  def install
    bin.install "docker-credential-helper-ecr"
  end

  test do
    system "#{bin}/docker-credential-helper-ecr"
  end
end
