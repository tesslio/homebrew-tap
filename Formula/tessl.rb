class Tessl < Formula
  desc ""
  homepage ""
  url "https://registry.npmjs.org/@tessl/cli/-/cli-0.24.0.tgz"
  sha256 "03d0cc0a76dd5e663c86f7efa656b096c675ae996e707e7b7807c01d8fc48781"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/foo --version")
  end
end
