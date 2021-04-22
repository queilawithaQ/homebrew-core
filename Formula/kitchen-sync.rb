class KitchenSync < Formula
  desc "Fast efficiently sync database without dumping & reloading"
  homepage "https://github.com/willbryant/kitchen_sync"
  url "https://github.com/willbryant/kitchen_sync/archive/v2.10.tar.gz"
  sha256 "98d2024df192571b7a5b4c21f0522d7d7187ac2a1411051e4594f3a66ebfa1af"
  license "MIT"
  head "https://github.com/willbryant/kitchen_sync.git"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any, big_sur:     "4d319227763ecb2d8b01adafa821a806c91963e366ea4341a92a850429fb6115"
    sha256 cellar: :any, catalina:    "6b5366aa8413f25ff8985cb7d195723a78c9c42bc4af1eb50b9980e1694e605e"
    sha256 cellar: :any, mojave:      "900f81a4a99ad8b1aef571d8c1d20de1edf102dbd9d202832c6f96a09b6f4454"
    sha256 cellar: :any, high_sierra: "80e91aab20f98adb5265fe24d39cbc4b8a10d66d2ec6663ad7ec294206554eb2"
  end

  depends_on "cmake" => :build
  depends_on "libpq"
  depends_on "mysql-client"

  def install
    system "cmake", ".",
                    "-DMySQL_INCLUDE_DIR=#{Formula["mysql-client"].opt_include}/mysql",
                    "-DMySQL_LIBRARY_DIR=#{Formula["mysql-client"].opt_lib}",
                    "-DPostgreSQL_INCLUDE_DIR=#{Formula["libpq"].opt_include}",
                    "-DPostgreSQL_LIBRARY_DIR=#{Formula["libpq"].opt_lib}",
                    *std_cmake_args

    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/ks --from mysql://b/ --to mysql://d/ 2>&1", 1)

    assert_match "Unknown MySQL server host", output
    assert_match "Kitchen Syncing failed.", output
  end
end
