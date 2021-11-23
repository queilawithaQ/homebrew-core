class Istioctl < Formula
  desc "Istio configuration command-line utility"
  homepage "https://istio.io/"
  url "https://github.com/istio/istio.git",
      tag:      "1.12.0",
      revision: "016bc46f4a5e0ef3fa135b3c5380ab7765467c1a"
  license "Apache-2.0"
  head "https://github.com/istio/istio.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "3153bd861e0152480ff0239b503b8fddf665d80f8d26e2ced5caff356d47596c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "3153bd861e0152480ff0239b503b8fddf665d80f8d26e2ced5caff356d47596c"
    sha256 cellar: :any_skip_relocation, monterey:       "59cdd78e0c1419e58f87408f78f2b799a3a9a7b86a2a132f2f1aba040d0690e6"
    sha256 cellar: :any_skip_relocation, big_sur:        "59cdd78e0c1419e58f87408f78f2b799a3a9a7b86a2a132f2f1aba040d0690e6"
    sha256 cellar: :any_skip_relocation, catalina:       "59cdd78e0c1419e58f87408f78f2b799a3a9a7b86a2a132f2f1aba040d0690e6"
  end

  depends_on "go" => :build
  depends_on "go-bindata" => :build

  # Fix https://github.com/istio/istio/issues/35831
  # remove in next release
  patch do
    url "https://github.com/istio/istio/commit/6d9c69f10431bca2ee2beefcfdeaad5e5f62071b.patch?full_index=1"
    sha256 "47e175fc0ac5e34496c6c0858eefbc31e45073dad9683164f7a21c74dbaa6055"
  end

  def install
    # make parallelization should be fixed in version > 1.12.0
    ENV.deparallelize
    ENV["VERSION"] = version.to_s
    ENV["TAG"] = version.to_s
    ENV["ISTIO_VERSION"] = version.to_s
    ENV["HUB"] = "docker.io/istio"
    ENV["BUILD_WITH_CONTAINER"] = "0"

    dirpath = if OS.linux?
      "linux_amd64"
    elsif Hardware::CPU.arm?
      # Fix missing "amd64" for macOS ARM in istio/common/scripts/setup_env.sh
      # Can remove when upstream adds logic to detect `$(uname -m) == "arm64"`
      ENV["TARGET_ARCH"] = "arm64"

      "darwin_arm64"
    else
      "darwin_amd64"
    end

    system "make", "istioctl", "istioctl.completion"
    cd "out/#{dirpath}" do
      bin.install "istioctl"
      bash_completion.install "release/istioctl.bash"
      zsh_completion.install "release/_istioctl"
    end
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/istioctl version --remote=false").strip
  end
end
