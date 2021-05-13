class ExtraCmakeModules < Formula
  desc "Extra modules and scripts for CMake"
  homepage "https://api.kde.org/frameworks/extra-cmake-modules/html/index.html"
  url "https://download.kde.org/stable/frameworks/5.81/extra-cmake-modules-5.81.0.tar.xz"
  sha256 "5f57e4b843069b6098d955051bb2913558d1623fead3f3b95b7017d7e1e35b83"
  license all_of: ["BSD-2-Clause", "BSD-3-Clause", "MIT"]
  head "https://invent.kde.org/frameworks/extra-cmake-modules.git"

  # We check the tags from the `head` repository because the latest stable
  # version doesn't seem to be easily available elsewhere.
  livecheck do
    url :head
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "68feeefebc4993eb39d062913c02157d1619ae6af53913ec43602f5eec96581a"
    sha256 cellar: :any_skip_relocation, big_sur:       "e64b163fc1ef5d2faf84380c71a6574b351698722ec701028492863b737ae9e9"
    sha256 cellar: :any_skip_relocation, catalina:      "9128cf95c7d0a1c2426a82df46b0d9a34e9f0c1c1f1a06eb7a30b05b92bf547a"
    sha256 cellar: :any_skip_relocation, mojave:        "e64b163fc1ef5d2faf84380c71a6574b351698722ec701028492863b737ae9e9"
  end

  depends_on "cmake" => [:build, :test]
  depends_on "qt@5" => :build
  depends_on "sphinx-doc" => :build

  def install
    args = std_cmake_args
    args << "-DBUILD_HTML_DOCS=ON"
    args << "-DBUILD_MAN_DOCS=ON"
    args << "-DBUILD_QTHELP_DOCS=ON"
    args << "-DBUILD_TESTING=OFF"

    system "cmake", ".", *args
    system "make", "install"
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(ECM REQUIRED)")
    system "cmake", ".", "-Wno-dev"

    expected="ECM_DIR:PATH=#{HOMEBREW_PREFIX}/share/ECM/cmake"
    assert_match expected, File.read(testpath/"CMakeCache.txt")
  end
end
