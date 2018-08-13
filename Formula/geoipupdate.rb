class Geoipupdate < Formula
  desc "Automatic updates of GeoIP2 and GeoIP Legacy databases"
  homepage "https://github.com/maxmind/geoipupdate"
  url "https://github.com/maxmind/geoipupdate/releases/download/v3.0.0/geoipupdate-3.0.0.tar.gz"
  sha256 "0caa618b5b541fe6ef12a29362f0a19138ce6ab89b7581aaa9b21a2605534dac"

  bottle do
    sha256 "22feb6fb330b62c077482b443ac637c2fa3f60626b4113d815fc0fd85a255ee2" => :high_sierra
    sha256 "d28503bce47a42732d54cece163675f6c6169539327a95bb8d4bbdfd16aa9e35" => :sierra
    sha256 "ab7981329380d9bf0fee2efe0bfed2a1745cc3ecf681356ba21a02cd6604acf2" => :el_capitan
  end

  head do
    url "https://github.com/maxmind/geoipupdate.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    system "./bootstrap" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--datadir=#{var}",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}"
    system "make", "install"
  end

  def post_install
    (var/"GeoIP").mkpath
    system bin/"geoipupdate", "-v"
  end

  test do
    system "#{bin}/geoipupdate", "-V"
  end
end
