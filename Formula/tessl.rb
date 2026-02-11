require "pathname"

class Tessl < Formula
  desc "CLI and MCP to provide coding agents the context they are missing"
  homepage "https://tessl.io"
  version "0.63.2"
  url "https://install.tessl.io/installers/0.63.2.tgz"
  sha256 "887be92ec4bb8fcd8b4c9ad61e71c2d1ca0300679354577b1ad5f25d7aeac257"
  license ""

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args(ignore_scripts: false)
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
    assert system("#{bin}/tessl", "--version")
  end
end
