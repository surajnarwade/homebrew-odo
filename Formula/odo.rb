class Odo < Formula
  desc "OpenShift Command-line for Developers"
  homepage "https://github.com/redhat-developer/odo"
  url "https://github.com/redhat-developer/odo/archive/v0.0.10.tar.gz"
  sha256 "c93ca0438c970c83394b5d2dd29e3dcfff2e8df82fb242e36cf176d695b9a488"

  head do
    url "https://github.com/redhat-developer/odo.git"
  end


  depends_on "go" => :build
  depends_on "openshift-cli"

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/redhat-developer").mkpath
    ln_s buildpath, buildpath/"src/github.com/redhat-developer/odo"
    system "make", "bin"
    bin.install "odo"
  end

  test do
    # all other odo commands are requiring running OpenShift cluster
    assert_match version.to_s, shell_output("#{bin}/odo version")
  end
end
