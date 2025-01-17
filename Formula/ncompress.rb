class Ncompress < Formula
  desc "Fast, simple LZW file compressor"
  homepage "https://github.com/vapier/ncompress"
  url "https://github.com/vapier/ncompress/archive/v5.0.tar.gz"
  sha256 "96ec931d06ab827fccad377839bfb91955274568392ddecf809e443443aead46"
  license "Unlicense"
  head "https://github.com/vapier/ncompress.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1ed0a835e287915e90e45a75971aefd707578cf96ddcbe631fd8bab34000af98"
    sha256 cellar: :any_skip_relocation, big_sur:       "b78cd2bde25384f42fd1f5d29ec6b1a909449e6f20c20c44c232885d0d99acbe"
    sha256 cellar: :any_skip_relocation, catalina:      "55220d13762facae37b84f1b6fcc6ec696daee5cc8b8478b868f5f7e34123af2"
    sha256 cellar: :any_skip_relocation, mojave:        "e680253759776cc3de92aee1afac39c180f1758113bc56e25bbd469206df0c5a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5be1d38d68a01895cb10dc31342e9e1cb9252cc01646698dae981c558c51fe70" # linuxbrew-core
  end

  keg_only :provided_by_macos

  def install
    system "make", "install", "BINDIR=#{bin}", "MANDIR=#{man1}"
  end

  test do
    Pathname.new("hello").write "Hello, world!"
    system "#{bin}/compress", "-f", "hello"
    assert_match "Hello, world!", shell_output("#{bin}/compress -cd hello.Z")
  end
end
