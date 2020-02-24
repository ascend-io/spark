def version_string(string, versions):
    return string.format(**versions)

def version_artifacts(artifacts, versions):
    versioned = []

    for artifact in artifacts:
        components = artifact.split(":")

        if len(components) == 2:
            key = components[1].replace(".", "-").replace("_{scala}", "")
            artifact = artifact + ":{" + key + "}"

        versioned.append(artifact.format(**versions))

    return versioned
