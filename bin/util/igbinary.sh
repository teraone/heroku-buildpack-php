#!/bin/bash

	if [[ "$engine" == "php" && -n "$NEW_RELIC_LICENSE_KEY" ]] && ! $engine -n $(which composer) show -d "$build_dir/.heroku/php" --installed --quiet heroku-sys/ext-newrelic 2>/dev/null; then
		if $engine -n $(which composer) require --update-no-dev -d "$build_dir/.heroku/php" -- "heroku-sys/ext-igbinary:*" >> $build_dir/.heroku/php/install.log 2>&1; then
			echo "- New Relic detected, installed ext-igbinary" | indent
		else
			mcount "warnings.addons.newrelic.extension_missing"
			warning_inline "New Relic detected, but no suitable extension (igbinary) available"
		fi
	fi
