class Mapnik < Formula
  desc "Toolkit for developing mapping applications"
  homepage "https://mapnik.org/"
  url "https://github.com/mapnik/mapnik/releases/download/v3.1.0/mapnik-v3.1.0.tar.bz2"
  sha256 "43d76182d2a975212b4ad11524c74e577576c11039fdab5286b828397d8e6261"
  license "LGPL-2.1-or-later"
  revision 1
  head "https://github.com/mapnik/mapnik.git"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any, arm64_big_sur: "669da46fed32e90a6fc295c415925d1db8c3f7a94f79164534e25c69fe0ba752"
    sha256 cellar: :any, big_sur:       "db2d29bf1aa3f39ec18321d08a1eb358d92853ea13c8af248cd619edc74d877e"
    sha256 cellar: :any, catalina:      "95218e2eee58e1056a11465a5265843b0a351328ad1f629d0a40603f0a3c3ac9"
    sha256 cellar: :any, mojave:        "1dd11a537da2d3ab40bdd026f90c54e687fc2e2380677acf94d11987a5530d1a"
  end

  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "cairo"
  depends_on "freetype"
  depends_on "gdal"
  depends_on "harfbuzz"
  depends_on "icu4c"
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "postgresql"
  depends_on "proj"
  depends_on "webp"

  def install
    ENV.cxx11

    # Work around "error: no member named 'signbit' in the global namespace"
    # encountered when trying to detect boost regex in configure
    ENV.delete("SDKROOT") if DevelopmentTools.clang_build_version >= 900

    # Use Proj 6.0.0 compatibility headers
    # https://github.com/mapnik/mapnik/issues/4036
    ENV.append_to_cflags "-DACCEPT_USE_OF_DEPRECATED_PROJ_API_H"

    boost = Formula["boost"].opt_prefix
    freetype = Formula["freetype"].opt_prefix
    harfbuzz = Formula["harfbuzz"].opt_prefix
    icu = Formula["icu4c"].opt_prefix
    jpeg = Formula["jpeg"].opt_prefix
    libpng = Formula["libpng"].opt_prefix
    libtiff = Formula["libtiff"].opt_prefix
    proj = Formula["proj"].opt_prefix
    webp = Formula["webp"].opt_prefix

    args = %W[
      CC=#{ENV.cc}
      CXX=#{ENV.cxx}
      PREFIX=#{prefix}
      BOOST_INCLUDES=#{boost}/include
      BOOST_LIBS=#{boost}/lib
      CAIRO=True
      CPP_TESTS=False
      FREETYPE_CONFIG=#{freetype}/bin/freetype-config
      GDAL_CONFIG=#{Formula["gdal"].opt_bin}/gdal-config
      HB_INCLUDES=#{harfbuzz}/include
      HB_LIBS=#{harfbuzz}/lib
      ICU_INCLUDES=#{icu}/include
      ICU_LIBS=#{icu}/lib
      INPUT_PLUGINS=all
      JPEG_INCLUDES=#{jpeg}/include
      JPEG_LIBS=#{jpeg}/lib
      NIK2IMG=False
      PG_CONFIG=#{Formula["postgresql"].opt_bin}/pg_config
      PNG_INCLUDES=#{libpng}/include
      PNG_LIBS=#{libpng}/lib
      PROJ_INCLUDES=#{proj}/include
      PROJ_LIBS=#{proj}/lib
      TIFF_INCLUDES=#{libtiff}/include
      TIFF_LIBS=#{libtiff}/lib
      WEBP_INCLUDES=#{webp}/include
      WEBP_LIBS=#{webp}/lib
    ]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    output = shell_output("#{bin}/mapnik-config --prefix").chomp
    assert_equal prefix.to_s, output
  end
end
