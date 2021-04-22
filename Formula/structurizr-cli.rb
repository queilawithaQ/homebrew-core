class StructurizrCli < Formula
  desc "Command-line utility for Structurizr"
  homepage "https://structurizr.com"
  url "https://github.com/structurizr/cli/releases/download/v1.9.0/structurizr-cli-1.9.0.zip"
  sha256 "3c7a8166666cb87d6598d3987d553f02f39036426f016369774becc8f2e3449e"
  license "Apache-2.0"

  bottle :unneeded

  depends_on "openjdk"

  def install
    libexec.install "structurizr-cli-#{version}.jar"
    bin.write_jar_script libexec/"structurizr-cli-#{version}.jar", "structurizr-cli"
  end

  test do
    expected_output = <<~EOS.strip
      Structurizr CLI v#{version}
      Usage: structurizr push|pull|lock|unlock|export|validate [options]
    EOS
    result = pipe_output("#{bin}/structurizr-cli").strip
    assert_equal result, expected_output
  end
end
