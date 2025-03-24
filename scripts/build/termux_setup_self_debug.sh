termux_print_stacktrace() {
	local func src lineno
	echo "💥 Error occurred at line $1 in script ${BASH_SOURCE[1]}"
	echo "🔍 Stack trace:"
	for i in "${!FUNCNAME[@]}"; do
		func="${FUNCNAME[$i]}"
		src="${BASH_SOURCE[$i]}"
		lineno="${BASH_LINENO[$((i - 1))]}"
		# skip print_stacktrace itself
		(( $i )) && echo "  at $func() in $src:$lineno"
	done
	[[ -n "${TERMUX_PKG_NAME:-}" ]] && echo "  while trying to build package ${TERMUX_PKG_NAME:-}"
}

trap 'termux_print_stacktrace $LINENO' ERR
