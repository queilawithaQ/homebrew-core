class Gdu < Formula
  desc "Disk usage analyzer with console interface written in Go"
  homepage "https://github.com/dundee/gdu"
  url "https://github.com/dundee/gdu/archive/v4.11.2.tar.gz"
  sha256 "e192aad836a67bf810358c548897bd9723a6831ad1a33b255ef4a27e6ad4a8ae"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "72c0b00dc4fed7111ecf5dee290e30f8a057586d1e0afc2ab59a044320f58fa0"
    sha256 cellar: :any_skip_relocation, big_sur:       "aaaabe645126a1562fa6e2e8da69bf81574dccba5bb835f9d156eddeff32f63a"
    sha256 cellar: :any_skip_relocation, catalina:      "d0d5960fb1f24c40a2b43a5be59c20f36561f3aa7bf8472da40ce6d10b92e0aa"
    sha256 cellar: :any_skip_relocation, mojave:        "50fdcd00b7f14b8a4c8780ef2ba0bed6e2f27d08fc82ac47aee9448e26b91066"
  end

  depends_on "go" => :build

  conflicts_with "coreutils", because: "both install `gdu` binaries"

  def install
    time = Time.new
    user = Utils.safe_popen_read("id", "-u", "-n")

    ldflags = %W[
      -s -w
      -X 'github.com/dundee/gdu/v4/build.Version=v#{version}'
      -X 'github.com/dundee/gdu/v4/build.Time=#{time}'
      -X 'github.com/dundee/gdu/v4/build.User=#{user}'
    ]

    system "go", "build", *std_go_args(ldflags: ldflags.join(" ")), "github.com/dundee/gdu/v4/cmd/gdu"
  end

  test do
    mkdir_p testpath/"test_dir"
    (testpath/"test_dir"/"file1").write "hello"
    (testpath/"test_dir"/"file2").write "brew"

    assert_match version.to_s, shell_output("#{bin}/gdu -v")
    assert_match "colorized", shell_output("#{bin}/gdu --help 2>&1")
    assert_match "4.0 KiB file1", shell_output("#{bin}/gdu --non-interactive --no-progress #{testpath}/test_dir 2>&1")
  end
end
