class DvdVr < Formula
  desc "Utility to identify and extract recordings from DVD-VR files"
  homepage "https://www.pixelbeat.org/programs/dvd-vr/"
  url "https://www.pixelbeat.org/programs/dvd-vr/dvd-vr-0.9.7.tar.gz"
  sha256 "19d085669aa59409e8862571c29e5635b6b6d3badf8a05886a3e0336546c938f"
  license "GPL-2.0"

  livecheck do
    url :homepage
    regex(/href=.*?dvd-vr[._-]v?(\d+(?:\.\d+)+)\.t/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "34cfb579dcddb0ded88010dea55a3b5bb4d78628ab6c0bc0e7f70d93882b2156"
    sha256 cellar: :any_skip_relocation, big_sur:       "4c1ab9eca5fcff27e5aa6185a9b908c1c4c0569ceede8ef574d8365da6f1d914"
    sha256 cellar: :any_skip_relocation, catalina:      "bd9d4471e3e4832bbfcc4ddf0fa34f32bfe0fc6efea5ec17414157cc060a141d"
    sha256 cellar: :any_skip_relocation, mojave:        "1f815f7699e3bb885c56c3842e9d43ef58d3b338a1405f2f33b26a1b975a1061"
    sha256 cellar: :any_skip_relocation, high_sierra:   "e96bdfc31d58a3d94f739937c0efbbdd0b2a60a625aa8c33033e71adf8ee040c"
    sha256 cellar: :any_skip_relocation, sierra:        "7b38c83a9bb9daded6a6f28be018076cdcdbbfb0d47102ecbdd06128bebb33ee"
    sha256 cellar: :any_skip_relocation, el_capitan:    "a048c7985df06e3a1d4c7145064b87bd51945f15da2494c03e7af542f07ca8b4"
    sha256 cellar: :any_skip_relocation, yosemite:      "22919ace8aeedc16d406797273402498c0c97ceec31e2dfbffcba6fff957ce65"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a88e4ac057d6ae1fef7f0e82342ce3f6e80f40a4c7cde9a46bfb55bd1d0875b" # linuxbrew-core
  end

  def install
    system "make", "PREFIX=#{prefix}", "install"
  end

  test do
    system "#{bin}/dvd-vr", "--version"
  end
end
