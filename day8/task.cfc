component extends="AdventOfCodeTask" {

	function partOne() {
		var count = getPuzzleInputAsArray()
			.map( ( line ) => trim( listLast( line, "|" ) ) )
			.map( ( output ) => output.listToArray( " " )
				.filter( ( output ) => arrayContains( [ 2, 3, 4, 7 ], output.len() ) > 0  )
				.len() )
			.sum()
			
		print.line( count );
	}

	function partTwo() {
		var total = getPuzzleInputAsArray()
			.map( convertLineToOutputValue )
			.sum();
		print.line( total );
	}

	function convertLineToOutputValue( required string line ) {
		var parsedInput = arguments.line.listToArray( "|" )
			.map( ( part ) => {
				return part
					.trim()
					.listToArray( " " )
					.map( ( pattern ) => {
						var patternArray = pattern.listToArray( "" );
						patternArray.sort( "text" );
						return patternArray.toList( "" );
					} );
			} );
		var patterns = parsedInput[ 1 ];
		var output = parsedInput[ 2 ];

		// 1, 4, 7 and 8 each have a unique number of signals.
		var signals = {
			"1": findAndPop( patterns, 2 ),
			"4": findAndPop( patterns, 4 ),
			"7": findAndPop( patterns, 3 ),
			"8": findAndPop( patterns, 7 ),
		};

		// 9 is the only remaining digit that has a 4 in it.
		signals[ 9 ] = findAndPop( patterns, ( a ) => includes( a, signals[ 4 ] ) );

		// The remaining digits with 6 signals are 6 and 0.
		// 0 has a 1 in it while 6 does not.
		signals[ 0 ] = findAndPop( patterns, ( a ) => ( a.len() == 6 ) && includes( a, signals[ 1 ] ) );

		// 6 is now the only remaining digit with 6 signals.
		signals[ 6 ] = findAndPop( patterns, 6 );

		// 2, 3 and 5 remain. From these digits, 3 is the only
		// one that contains a 7.
		signals[ 3 ] = findAndPop( patterns, ( a ) => includes( a, signals[ 7 ] ) );

		// 2 and 5 remain. 2 has 2 signals in common with 4 while
		// 5 has 3 signals in common with 4.
		signals[ 2 ] = findAndPop( patterns, ( a ) => substract( signals[ 4 ], a ).len() == 2 );

		// Only 5 remains. It has 5 signals.
		signals[ 5 ] = findAndPop( patterns, 5 );

		var signalMap = structFlip( signals );
		return output.map( ( o ) => signalMap[ o ] ).toList( "" ).trim();
	}

	function findAndPop( required array inputs, required any condition ) {
		if ( !isClosure( arguments.condition ) && !isCustomFunction( arguments.condition ) ) {
			var length = arguments.condition;
			arguments.condition = ( a ) => a.len() == length;
		}
		var index = arrayFindIndex( arguments.inputs, arguments.condition );
		var value = arguments.inputs[ index ];
		arrayDeleteAt( arguments.inputs, index );
		return value;
	}

	public numeric function arrayFindIndex( required array arr, required function predicate ) {
		for ( var i = 1; i <= arguments.arr.len(); i++ ) {
			if ( arguments.predicate( arguments.arr[ i ] ) ) {
				return i;
			}
		}
		return 0;
	}

	function substract( required string a, required string b ) {
		return arguments.a.listToArray( "" )
			.filter( ( c ) => find( c, b ) == 0 )
			.toList( "" );
	}

	function includes( required string a, required string b ) {
		return substract( arguments.b, arguments.a ).len() == 0;
	}

	function structFlip( required struct s ) {
		return arguments.s.reduce( ( flipped, key, value ) => {
			flipped[ value ] = key;
			return flipped;
		}, {} );
	}

// 	function getPuzzleInput() {
// 		return "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
// edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
// fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
// fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
// aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
// fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
// dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
// bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
// egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
// gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce";
// 	}

}
