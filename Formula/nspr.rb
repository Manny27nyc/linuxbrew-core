class Nspr < Formula
  desc "Platform-neutral API for system-level and libc-like functions"
  homepage "https://developer.mozilla.org/docs/Mozilla/Projects/NSPR"
  url "https://archive.mozilla.org/pub/nspr/releases/v4.32/src/nspr-4.32.tar.gz"
  sha256 "bb6bf4f534b9559cf123dcdc6f9cd8167de950314a90a88b2a329c16836e7f6c"
  license "MPL-2.0"

  livecheck do
    url "https://ftp.mozilla.org/pub/nspr/releases/"
    regex(%r{href=.*?v?(\d+(?:\.\d+)+)/?["' >]}i)
  end

  bottle do
    sha256 cellar: :any,                 arm64_big_sur: "69c39b2f0a2d93ea5969a9906d0e5063caa34ad495cd56cef7e22b8b8628a67a"
    sha256 cellar: :any,                 big_sur:       "fa4089b067d319a827833747ed64c0e9ed9ce1c95aa54d77fb1dabffd52436ed"
    sha256 cellar: :any,                 catalina:      "f5a4e62a6d63a398ce0d14af9aa25ad1c33c8eb9ff64de988551ee0791aae69b"
    sha256 cellar: :any,                 mojave:        "fd4bc5953ceff865f0a3e049fbb06ccb07015c4369a7aa4c67e820af6b7cc53b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6dcc7ee7c2e9e2614bdca418dbbe39473f9d00df987ad2b67dd9bc8885c77fec" # linuxbrew-core
  end

  def install
    ENV.deparallelize
    cd "nspr" do
      args = %W[
        --disable-debug
        --prefix=#{prefix}
        --enable-strip
        --with-pthreads
        --enable-ipv6
        --enable-macos-target=#{MacOS.version}
        --enable-64bit
      ]
      system "./configure", *args

      if OS.mac?
        # Remove the broken (for anyone but Firefox) install_name
        inreplace "config/autoconf.mk", "-install_name @executable_path/$@ ", "-install_name #{lib}/$@ "
      end

      system "make"
      system "make", "install"

      (bin/"compile-et.pl").unlink
      (bin/"prerr.properties").unlink
    end
  end

  test do
    system "#{bin}/nspr-config", "--version"
  end
end
