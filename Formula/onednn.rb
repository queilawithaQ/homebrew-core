class Onednn < Formula
  desc "Basic building blocks for deep learning applications"
  homepage "https://01.org/oneDNN"
  url "https://github.com/oneapi-src/oneDNN/archive/v2.4.4.tar.gz"
  sha256 "29ce33da3eaf48cbc39cfd9e9af0d7d00e256dcd84168b906df48fb75f5f844e"
  license "Apache-2.0"
  head "https://github.com/oneapi-src/onednn.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_monterey: "c88c9ffdba5b3640190d3d7adcee9f56175aaab7264132b6faa7dc1bdd2faa83"
    sha256 cellar: :any,                 arm64_big_sur:  "3c720b5af591aef146c87549acac7677d25966e4a3de49c85dbbaa6717193082"
    sha256 cellar: :any,                 monterey:       "ac09dbb2968bb3a16b5af32f66b6db28af8178dd2cdf350efd43d960a8d50c92"
    sha256 cellar: :any,                 big_sur:        "b6c5a9a22b333c62f5e83cd9b3e9efcbfc9af30293efb3247ba8dac90008d213"
    sha256 cellar: :any,                 catalina:       "3cb2ace8b3250a9a73aea15a186974f278e528c1dcd2473b2a3eed42b566c044"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a569e52a0deea5aa3b86974eee7830fd1ba44590e93879ee094b69e8f345397b"
  end

  depends_on "cmake" => :build
  depends_on "doxygen" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "doc"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <mkldnn.h>
      int main() {
        mkldnn_engine_t engine;
        mkldnn_status_t status = mkldnn_engine_create(&engine, mkldnn_cpu, 0);
        return !(status == mkldnn_success);
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lmkldnn", "-o", "test"
    system "./test"
  end
end
