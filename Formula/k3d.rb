class K3d < Formula
  desc "Little helper to run Rancher Lab's k3s in Docker"
  homepage "https://k3d.io"
  url "https://github.com/rancher/k3d/archive/v4.3.0.tar.gz"
  sha256 "26113ef5e82ce57df18b08f3d40f43e57cd3ef53cfc7b5aad32993bc5dc5485b"
  license "MIT"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1c59cd5b94c87e800394d29f36d396e5e744f6aa46236a0a5cceb91febf28ad7"
    sha256 cellar: :any_skip_relocation, big_sur:       "b24fb2391f5279774ee89eb084b5b4560faf2dba1911e2157d4ddc2c34460d68"
    sha256 cellar: :any_skip_relocation, catalina:      "82d1a0e7368d6e1791901a7a978b043a671089af2d675cbea4385eebed0e4db8"
    sha256 cellar: :any_skip_relocation, mojave:        "6d9b79b7f0206d785ca856233136e660e6b69680fc6a6865fe94599029022b77"
  end

  depends_on "go" => :build

  def install
    system "go", "build",
           "-mod", "vendor",
           "-ldflags", "-s -w -X github.com/rancher/k3d/v#{version.major}/version.Version=v#{version}"\
           " -X github.com/rancher/k3d/v#{version.major}/version.K3sVersion=latest",
           "-trimpath", "-o", bin/"k3d"

    # Install bash completion
    output = Utils.safe_popen_read("#{bin}/k3d", "completion", "bash")
    (bash_completion/"k3d").write output

    # Install zsh completion
    output = Utils.safe_popen_read("#{bin}/k3d", "completion", "zsh")
    (zsh_completion/"_k3d").write output
  end

  test do
    assert_match "k3d version v#{version}\nk3s version latest (default)", shell_output("#{bin}/k3d --version")
    # Either docker is not present or it is, where the command will fail in the first case.
    # In any case I wouldn't expect a cluster with name 6d6de430dbd8080d690758a4b5d57c86 to be present
    # (which is the md5sum of 'homebrew-failing-test')
    output = shell_output("#{bin}/k3d cluster get 6d6de430dbd8080d690758a4b5d57c86 2>&1", 1).split("\n").pop
    assert_match "No nodes found for given cluster", output
  end
end
