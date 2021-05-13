class Docfx < Formula
  desc "Tools for building and publishing API documentation for .NET projects"
  homepage "https://dotnet.github.io/docfx/"
  url "https://github.com/dotnet/docfx/releases/download/v2.57.2/docfx.zip"
  sha256 "9f6d01b35cecf852902325b50f05b6f1a66aa6de46a98a96573d75d0c53e90c9"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "7227b58875815ab6d25816c814d6a1bc86fba213ed0c97378579c222707f9aab"
  end

  depends_on arch: :x86_64
  depends_on "mono"

  def install
    libexec.install Dir["*"]

    (bin/"docfx").write <<~EOS
      #!/bin/bash
      mono #{libexec}/docfx.exe "$@"
    EOS
  end

  test do
    system bin/"docfx", "init", "-q"
    assert_predicate testpath/"docfx_project/docfx.json", :exist?,
                     "Failed to generate project"
  end
end
