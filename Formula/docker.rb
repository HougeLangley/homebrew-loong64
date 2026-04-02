class Docker < Formula
  desc "Pack, ship and run any application as a lightweight container"
  homepage "https://www.docker.com/"
  url "https://github.com/docker/docker-ce.git",
      tag:      "v27.5.1",
      revision: "9f9e4058019a3c033bf745f96e0d0f8b7f52b9e5"
  license "Apache-2.0"

  depends_on "go" => :build
  depends_on "go-md2man" => :build

  def install
    ENV["AUTO_GOPATH"] = "1"
    ENV["DOCKER_GITCOMMIT"] = Utils.git_short_head
    ENV["VERSION"] = version

    system "make", "binary"
    
    bin.install "bundles/binary-daemon/dockerd"
    bin.install "bundles/binary-daemon/docker-proxy"
    bin.install "bundles/binary-client/docker"
  end

  test do
    system bin/"docker", "--version"
  end
end
