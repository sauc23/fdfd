#!/bin/ash

npm audit fix

p=""
[[ "${HTTP}" == 1 ]] && p=$p'--http '
[[ "${UDP}" -eq 1 ]] && p=$p'--udp '
[[ "${WS}" -eq 1 ]] && p=$p'--ws '
if [[ "${SILENT}" -eq 0 ]]; then
  [[ "${QUIET}" -eq 1 ]] && p=$p'-q '
else
  p=$p'-s '
fi
p=$p"--trust-proxy $([[ ${TRUST_PROXY} -eq 1 ]] && echo true || echo false) "
p=$p"--stats $([[ ${STATS} -eq 1 ]] && echo true || echo false) "
p=$p"--interval ${INTERVAL} "
p=$p"-p ${PORT}"

echo "Parameters: ${p}"
NODE_ENV="production" bin/cmd.js ${p}
