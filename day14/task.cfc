component extends="AdventOfCodeTask" {

	function partOne( numeric steps = 10 ) {
		var input = parsePuzzleInput();
		var polymer = input.template;
		for ( var i = 1; i <= steps; i++ ) {
			polymer = polymerization( polymer, input.rules );
		}
		var polymerGroupedByLetter = arrayGroup( polymer.listToArray( "" ) );
		print.line( polymerGroupedByLetter );
		var max = polymerGroupedByLetter.valueArray().max();
		var min = polymerGroupedByLetter.valueArray().min();
		print.yellow( "#max# - #min# = " ).greenLine( max - min );
	}

	function partTwo( numeric steps = 40 ) {
		var input = parsePuzzleInput();
		var polymer = input.template;
		// Struct to track number of each pair
		var pairCounts = input.rules.reduce( ( acc, rule ) => {
			acc[ rule.pair ] = 0;
			return acc;
		}, {} );
		// Initial counts from template
		for ( var i = 1; i < input.template.len(); i++ ) {
			pairCounts[ mid( input.template, i, 2 ) ]++;
		}

		for ( var step = 1; step <= steps; step++ ) {
			// Copy current counts object by value
			var stepCounts = duplicate( pairCounts );
			input.rules.each( ( rule ) => {
				var pairCount = stepCounts[ rule.pair ];
				pairCounts[ rule.pair ] -= pairCount;
				pairCounts[ rule.pair[ 1 ] & rule.insert ] += pairCount;
				pairCounts[ rule.insert & rule.pair[ 2 ] ] += pairCount;
			} );
		}

		// Count instances of each letter (pairs containing letter / 2)
		var counts = {};
		for ( var pair in pairCounts ) {
			var part1 = pair[ 1 ];
			var part2 = pair[ 2 ];
			if ( !counts.keyExists( part1 ) ) {
				counts[ part1 ] = 0;
			}
			counts[ part1 ] += pairCounts[ pair ] / 2;
			if ( !counts.keyExists( part2 ) ) {
				counts[ part2 ] = 0;
			}
			counts[ part2 ] += pairCounts[ pair ] / 2;
		}

		var max = counts.valueArray().map( ( count ) => round( count ) ).max();
		var min = counts.valueArray().map( ( count ) => round( count ) ).min();
		print.yellow( "#max# - #min# = " ).greenLine( max - min );
	}

	private struct function parsePuzzleInput() {
		var parts = listSplit( getPuzzleInput(), "\n\n" );
		return {
			"template": parts[ 1 ],
			"rules": listSplit( parts[ 2 ].replace( "\n", chr( 10 ) ), "\n" )
				.map( ( rule ) => {
					var ruleParts = listSplit( rule, " -> " );
					return {
						"pair": ruleParts[ 1 ],
						"insert": ruleParts[ 2 ]
					};
				} )
		};
	}

	private string function polymerization( template, rules ) {
		var polymer = "";
		for ( var i = 1; i < arguments.template.len(); i++ ) {
			var pair = mid( arguments.template, i, 2 );
			polymer &= pair[ 1 ];
			var applicableRule = arguments.rules.filter( ( rule ) => rule.pair == pair );
			if ( !applicableRule.isEmpty() ) {
				polymer &= applicableRule[ 1 ].insert;
			}
			if ( i + 1 == arguments.template.len() ) {
				polymer &= pair[ 2 ];
			}
		}
		return polymer;
	}

	private string function polymerizationV2( template, rules, counts = {} ) {
		var polymer = "";
		for ( var i = 1; i < arguments.template.len(); i++ ) {
			var pair = mid( arguments.template, i, 2 );
			polymer &= pair[ 1 ];
			if ( !arguments.counts.keyExists( pair[ 1 ] ) ) {
				arguments.counts[ pair[ 1 ] ] = 0;
			}
			arguments.counts[ pair[ 1 ] ]++;
			var applicableRule = arguments.rules.filter( ( rule ) => rule.pair == pair );
			if ( !applicableRule.isEmpty() ) {
				polymer &= applicableRule[ 1 ].insert;
				if ( !arguments.counts.keyExists( applicableRule[ 1 ].insert ) ) {
					arguments.counts[ applicableRule[ 1 ].insert ] = 0;
				}
				arguments.counts[ applicableRule[ 1 ].insert ]++;
			}
			if ( i + 1 == arguments.template.len() ) {
				polymer &= pair[ 2 ];
				if ( !arguments.counts.keyExists( pair[ 2 ] ) ) {
					arguments.counts[ pair[ 2 ] ] = 0;
				}
				arguments.counts[ pair[ 2 ] ]++;
			}
		}
		return polymer;
	}

	private struct function arrayGroup( required array arr ) {
		return arguments.arr.reduce( ( acc, value ) => {
			if ( !acc.keyExists( value ) ) {
				acc[ value ] = 0;
			}
			acc[ value ]++;
			return acc;
		}, {} );
	}

// 	function getPuzzleInput() {
// 		return "NNCB

// CH -> B
// HH -> N
// CB -> H
// NH -> C
// HB -> C
// HC -> B
// HN -> C
// NN -> C
// BH -> H
// NC -> B
// NB -> B
// BN -> B
// BB -> N
// BC -> B
// CC -> N
// CN -> C
// ";
// 	}

}
