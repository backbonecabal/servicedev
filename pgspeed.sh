#!/bin/bash
NPS_VERSION=1.14.36
cd
wget -O- https://github.com/apache/incubator-pagespeed-ngx/archive/v${NPS_VERSION}.tar.gz | tar -xz
nps_dir=$(find . -name "*pagespeed-ngx-${NPS_VERSION}" -type d)
cd "$nps_dir"
NPS_RELEASE_NUMBER=${NPS_VERSION/beta/}
NPS_RELEASE_NUMBER=${NPS_VERSION/stable/}
psol_url=https://dl.google.com/dl/page-speed/psol/${NPS_RELEASE_NUMBER}.tar.gz
[ -e scripts/format_binary_url.sh ] && psol_url=$(scripts/format_binary_url.sh PSOL_BINARY_URL)
wget -O- ${psol_url} | tar -xz  # extracts to psol/
