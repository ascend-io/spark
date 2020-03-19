def _strip_prefix(text, prefix):
    if text.startswith(prefix):
        return text[len(prefix):]
    return text

def _zip_impl(ctx):
    strip_prefixes = ctx.attr.strip_prefixes
    args = ctx.actions.args()
    args.add("c", ctx.outputs.zip.path)
    inputs = []
    for src in ctx.attr.srcs:
        for f in src.files.to_list():
            target = f.path
            for prefix in strip_prefixes:
                target = _strip_prefix(target, prefix)
            inputs.append(target + "=" + f.path)
    args.add_all(sorted(inputs))
    ctx.actions.run(
        inputs = [file for file in src.files.to_list() for src in ctx.attr.srcs],
        outputs = [ctx.outputs.zip],
        executable = ctx.executable._zipper,
        arguments = [args],
        progress_message = "Creating zip...",
        mnemonic = "zipper",
    )

zip = rule(
    implementation = _zip_impl,
    attrs = {
        "srcs": attr.label_list(),
        "strip_prefixes": attr.string_list(default = []),
        "_zipper": attr.label(default = Label("@bazel_tools//tools/zip:zipper"), cfg = "host", executable = True),
    },
    outputs = {"zip": "%{name}.zip"},
)
