require "pathname"

class Tessl < Formula
  desc "CLI and MCP to provide coding agents the context they are missing"
  homepage "https://tessl.io"
  url "https://install.tessl.io/releases/0.50.6.tgz"
  sha256 "8aed150cd0d1369a95bbe406fb29595e7b59714dc04d31bb1c49df2c660cb01e"
  license ""

  depends_on "node"

  option "with-version", "Install the test release"
  if build.with?("version") && ENV["HOMEBREW_TESSL_VERSION"]
    url "https://install.tessl.io/releases/#{ENV["HOMEBREW_TESSL_VERSION"]}.tgz"
    sha256 ""
  end

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def post_install
    npm_root = Utils.safe_popen_read("npm", "root", "-g").strip rescue nil
    has_global_npm_installed = !!npm_root && (Pathname.new(npm_root)/"@tessl/cli")&.exist?
    return opoo <<~EOS if has_global_npm_installed
      Existing global npm install detected! Consider removing:
        #{Tty.send(:red)}npm uninstall -g @tessl/cli#{Tty.reset}
    EOS

    which_list = Utils.safe_popen_read("bash", "-lc", "which -a tessl 2>/dev/null").lines.map(&:strip).uniq
    first_match = which_list.first || "#{HOMEBREW_PREFIX}/bin/tessl"
    homebrew_bin_first_in_path = [
      "#{HOMEBREW_PREFIX}/bin/tessl",
      "#{opt_bin}/tessl",
      "#{bin}/tessl",
    ].include?(first_match)
    opoo <<~EOS unless homebrew_bin_first_in_path
      More than one `#{Tty.send(:green)}tessl#{Tty.reset}` found on the $PATH:
        First match: #{Tty.send(:red)}#{which_list.first}#{Tty.reset}
        Homebrew:    #{Tty.send(:green)}#{HOMEBREW_PREFIX}/bin/tessl#{Tty.reset}
      Consider removing to avoid conflicts with Homebrew's installation.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/foo --version")
  end
end
