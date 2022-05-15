class BatsCore < Formula
  desc "Bash Automated Testing System"
  homepage "https://github.com/bats-core/bats-core"
  url "https://github.com/bats-core/bats-core/archive/v1.7.0.tar.gz"
  sha256 "ac70c2a153f108b1ac549c2eaa4154dea4a7c1cc421e3352f0ce6ea49435454e"
  license "MIT"

  bottle do
    sha256 cellar: :any_skip_relocation, all: "cc9565240ce17198f4d3bea1282fb872de2e05ec8c0e772337390baeaf65f61b"
  end

  depends_on "coreutils"

  uses_from_macos "bc" => :test

  conflicts_with "bats", because: "both install `bats` executables"

  def install
    system "./install.sh", prefix
  end

  test do
    (testpath/"test.sh").write <<~EOS
      @test "addition using bc" {
        result="$(echo 2+2 | bc)"
        [ "$result" -eq 4 ]
      }
    EOS
    assert_match "addition", shell_output("#{bin}/bats test.sh")
  end
end
