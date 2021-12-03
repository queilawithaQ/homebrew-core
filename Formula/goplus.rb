class Goplus < Formula
  desc "Programming language for engineering, STEM education, and data science"
  homepage "https://goplus.org"
  url "https://github.com/goplus/gop/archive/refs/tags/v1.0.32.tar.gz"
  sha256 "c008d6fcc8c8f3a08e69774a6e54dce82fae78414b6e5c45b5b619dd0572a139"
  license "Apache-2.0"
  head "https://github.com/goplus/gop.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_monterey: "56114433e2633b93826c47487573d7a7da512346e4c5e406043680ca728f53b6"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b71d2629dd115928a2177d4c74a48cf3a425c4399cb61397ced9b08ec66fa4b5"
    sha256 cellar: :any_skip_relocation, monterey:       "bd26c304c3b0e95b8efac152a1b1840e3e2c790ef9ba6e44a49244cb9ded7ae8"
    sha256 cellar: :any_skip_relocation, big_sur:        "f88b29efc6f6a05f2f68d8acb821e48886620f168974586c44d44af1b49c1a5d"
    sha256 cellar: :any_skip_relocation, catalina:       "32ade32cef033f0188765ce59a9fe776c95ed5ac70e7b413a28097f1d53dc5a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2fd4c3074f477fca0c0c2ece94b8cdb4b58f23a0e664490529d6e543a3f942b2"
  end

  depends_on "go"

  def install
    # Patch version to match the version of gop, currently it get version from git tag
    inreplace "env/version.go", /^\tbuildVersion string$/, "\tbuildVersion string = \"v#{version}\"" unless build.head?
    build_script = build.head? ? "cmd/make.go" : "cmd/install.go"

    ENV["GOPROOT_FINAL"] = libexec
    system "go", "run", build_script, "--install"

    libexec.install Dir["*"] - Dir[".*"]
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  test do
    (testpath/"hello.gop").write <<~EOS
      println("Hello World")
    EOS

    # Run gop fmt, run, build
    ENV.prepend "GO111MODULE", "on"

    assert_equal "v#{version}", shell_output("#{bin}/gop env GOPVERSION").chomp unless head?
    system bin/"gop", "fmt", "hello.gop"
    assert_equal "Hello World\n", shell_output("#{bin}/gop run hello.gop")

    (testpath/"go.mod").write <<~EOS
      module hello
    EOS

    system "go", "get", "github.com/goplus/gop/builtin"
    system bin/"gop", "build", "-o", "hello"
    assert_equal "Hello World\n", shell_output("./hello")
  end
end
