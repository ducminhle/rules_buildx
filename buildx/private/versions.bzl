"""Mirror of release info

TODO: generate this file from GitHub API"""

# The integrity hashes can be computed with
# shasum -b -a 384 [downloaded file] | awk '{ print $1 }' | xxd -r -p | base64

BUILDX_VERSIONS = {
    "0.28.0": {
        "darwin-amd64": "833291f48e2dded5ad98770811894a693a83a6618dbd30a31c0f7012988f2b3b",
        "darwin-arm64": "0165087b0726d73541d9bdcc29f322de6e5c8bf0d7365a0a77cb0060055f2ae4",
        "linux-amd64": "696bc104bac3bb708eff1af3f8bbc09fda0fd88f5757c1f9b404a35117889224",
        "linux-arm64": "4e850583cc68ffd8d739ddb8a782b83f2ef9d3bf437ae7c44da4fbfde2613a8e",
        "windows-amd64": "0e8d520269cbd3401de6fee5c5fe48d5a9750805aa0a04d5443eba6b33ba63ee",
        "windows-arm64": "a110ebbf2379bcfbf72d533c283a133a44ffed14090279494ea74290291567d6",
    },
}
