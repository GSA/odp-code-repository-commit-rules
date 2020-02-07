#!/bin/sh
expected_version="$1"

if [ "x${expected_version}" = "x" ]; then
    echo "expected version must be provided as a parameter"
    exit 1
fi

repo_path=$(git rev-parse --show-toplevel)
hooks_path="${repo_path}/.git/hooks"
version_path="${hooks_path}/gitleaks_version"
base_url="https://github.com/GSA/odp-code-repository-commit-rules/releases/download/${expected_version}"
raw_url="https://raw.githubusercontent.com/GSA/odp-code-repository-commit-rules/${expected_version}"
rules_url="${raw_url}/gitleaks/rules.toml"

# read the locally installed version we will need this later
# to make sure we are running the version the caller has expected
if [ -f "$version_path" ]; then
    actual_version=$(cat "$version_path")
fi

# set bin_name based on what operating system this is
os=$(uname -s | cut -d'_' -f 1)
if [ "$os" = "Linux" ]; then
    bin_name="gitleaks_linux"
elif [ "$os" = "Darwin" ]; then
    bin_name="gitleaks_darwin"
elif [ "$os" = "CYGWIN" ] || [ "$os" = "MINGW64" ]; then
	bin_name="gitleaks_windows.exe"
fi

bin_path="${hooks_path}/${bin_name}"

# if the gitleaks binary isn't available or it is the wrong version
# download the expected version
if [ ! -f "$bin_path" ] || [ "$actual_version" != "$expected_version" ]; then
    curl --silent -L -o "$bin_path" "${base_url}/${bin_name}"
    curl --silent -L -o "${hooks_path}/rules.toml" "${rules_url}"
    printf "$expected_version" > "$version_path"
fi

# if the SHA512 of the downloaded binary doesn't match the
# sum from the git repository at this tagged version, we 
# should abort and cleanup our local binary
actual_sum=$(sha512sum "${bin_path}" | cut -d' ' -f 1)
expected_sum=$(curl --silent -L "${raw_url}/gitleaks/sha512/${bin_name}.sum")
if [ "$actual_sum" != "$expected_sum" ]; then
    echo "SHA512 does not match, cleaning up downloaded binary."
    rm "$bin_path"
    exit 1
fi

# The binary looks good, if we are on non-Windows we
# should make it executable so we can run it
if [ "$os" = "Linux" ] || [ "$os" = "Darwin" ]; then
    chmod +x "$bin_path"
fi

# run the binary pointing it to the root of the
# local repository
exec "$bin_path" --repo-path="$repo_path"
