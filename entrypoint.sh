#!/bin/ash

npm audit fix

p=""
[[ "${HTTP:-1}" == 1 ]] && p=$p'--http '
[[ "${UDP:-1}" -eq 1 ]] && p=$p'--udp '
[[ "${WS:-1}" -eq 1 ]] && p=$p'--ws '
[[ "${SILENT:-0}" -eq 0 ]] \
  && [[ "${QUIET:-0}" -eq 1 ]] && p=$p'-q ' \
|| p=$p'-s '
p=$p"--trust-proxy $([[ ${TRUST_PROXY:-0} -eq 1 ]] && echo true || echo false) "
p=$p"--stats $([[ ${STATS:-1} -eq 1 ]] && echo true || echo false) "
p=$p"--interval ${INTERVAL:-600000} "
p=$p"-p ${PORT:-8000}"

echo "Parameters:" "${p}"
NODE_ENV="production" bin/cmd.js "${p}"
