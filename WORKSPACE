workspace(name = "spark")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load(
    ":defs.bzl",
    "artifacts",
    "excluded_artifacts",
    "scala_extra_jars",
    "scala_version_shas",
    "version_artifacts",
    "versions",
)

maven_servers = [
    "https://repo1.maven.org/maven2",
    "https://repo.spring.io/plugins-release",
]

grpc_tag = "1.21.0"

grpc_archive = "v{}".format(grpc_tag)

grpc_sha = "9bc289e861c6118623fcb931044d843183c31d0e4d53fc43c4a32b56d6bb87fa"

http_archive(
    name = "io_grpc_grpc_java",
    sha256 = grpc_sha,
    strip_prefix = "grpc-java-{}".format(grpc_tag),
    url = "https://github.com/grpc/grpc-java/archive/{}.tar.gz".format(grpc_archive),
)

load("@io_grpc_grpc_java//:repositories.bzl", "grpc_java_repositories")

grpc_java_repositories()

rules_scala_tag = "0366fb23cb91fee2847a8358472278ddc9940c5f"

rules_scala_sha = "3d40732974c31d83a126c36842b49a0bbcd07a52c0a94e039627abb70581e39c"

http_archive(
    name = "io_bazel_rules_scala",
    sha256 = rules_scala_sha,
    strip_prefix = "rules_scala-%s" % rules_scala_tag,
    url = "https://github.com/bazelbuild/rules_scala/archive/%s.zip" % rules_scala_tag,
)

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories(
    maven_servers = maven_servers,
    scala_extra_jars = scala_extra_jars,
    scala_version_shas = scala_version_shas,
)

register_toolchains("//toolchains:scala_toolchain")

RULES_JVM_EXTERNAL_TAG = "3.2"

RULES_JVM_EXTERNAL_SHA = "82262ff4223c5fda6fb7ff8bd63db8131b51b413d26eb49e3131037e79e324af"

http_archive(
    name = "rules_jvm_external",
    sha256 = RULES_JVM_EXTERNAL_SHA,
    strip_prefix = "rules_jvm_external-%s" % RULES_JVM_EXTERNAL_TAG,
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % RULES_JVM_EXTERNAL_TAG,
)

load("@rules_jvm_external//:defs.bzl", "maven_install")
load("@rules_jvm_external//:specs.bzl", "maven")

maven_install(
    artifacts = version_artifacts(artifacts) + [
        maven.artifact(
            group = "org.apache.hive",
            artifact = "hive-exec",
            version = versions["hive"],
            classifier = "core",
        ),
    ],
    excluded_artifacts = excluded_artifacts,
    maven_install_json = "@//:maven_install.json",
    repositories = maven_servers,
    strict_visibility = True,
    version_conflict_policy = "pinned",
)

# bazel run @unpinned_maven//:pin

load("@maven//:defs.bzl", "pinned_maven_install")

pinned_maven_install()

rules_antlr_tag = "0.5.0"

rules_antlr_sha = "26e6a83c665cf6c1093b628b3a749071322f0f70305d12ede30909695ed85591"

http_archive(
    name = "rules_antlr",
    sha256 = rules_antlr_sha,
    strip_prefix = "rules_antlr-%s" % rules_antlr_tag,
    urls = ["https://github.com/marcohu/rules_antlr/archive/%s.tar.gz" % rules_antlr_tag],
)

load("@rules_antlr//antlr:repositories.bzl", "rules_antlr_dependencies")

rules_antlr_dependencies("4.7.2")
