FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

python do_compile_prepend() {
    import re
    work_dir = d.getVar("COREBASE")
    sdk_meta_dir = work_dir + "/../meta-aspeed-sdk/.git"
    sdk_ver = ""
    try:
        res=bb.process.run(("git --git-dir=%s symbolic-ref -q --short HEAD ||" +
                            "git --git-dir=%s describe --tags --exact-match")
            % (sdk_meta_dir, sdk_meta_dir))[0].strip("\n")
        if re.match("^\d+\.\d+\.\d+$", res):
            sdk_ver=res
        else:
            sdk_ver=bb.process.run("git --git-dir=%s rev-parse HEAD"
                % sdk_meta_dir)[0].strip("\n")
    except Exception as e:
        print(e)
        bb.warn("Failed to get SDK version")
        pass
    d.setVar("SDK_VERSION", sdk_ver)
}

OS_RELEASE_FIELDS_append = " SDK_VERSION"
BB_DONT_CACHE = "1"

