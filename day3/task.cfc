component extends="AdventOfCodeTask" {

	function partOne() {
		var byteSize = getPuzzleInputAsArray()[ 1 ].len();
		var initialDiffByteArray = [];
		for ( var i = 1; i <= byteSize; i++ ) {
			initialDiffByteArray.append( 0 );
		}
		var gammaRateBinaryArray = getPuzzleInputAsArray()
			.reduce( ( diff, byte ) => {
				var bits = byte.listToArray( "" );
				return diff.map( ( bit, i ) => {
					return bit + ( bits[ i ] == 0 ? - 1 : 1 ); 
				} );
			}, initialDiffByteArray )
			.map( ( bit ) => bit > 0 ? 1 : 0 );
		
		var gammaRateBinary = gammaRateBinaryArray.toList( "" );
		var epsilonRateBinary = gammaRateBinaryArray.map( ( bit ) => bit == 1 ? 0 : 1 ).toList( "" );

		print.white( "Gamma Rate (binary): " ).greenLine( gammaRateBinary );
		var gammaRate = parseNumber( gammaRateBinary, "bin" );
		print.white( "Gamma Rate (decimal): " ).greenLine( gammaRate ).line();
		print.white( "Epsilon Rate (binary): " ).greenLine( epsilonRateBinary );
		var epsilonRate = parseNumber( epsilonRateBinary, "bin" );
		print.white( "Epsilon Rate (decimal): " ).greenLine( epsilonRate ).line();

		var answer = gammaRate * epsilonRate;

		print.white( "Answer: " ).green( "#gammaRate# x #epsilonRate# = " ).boldBlueLine( answer );
	}

	function partTwo() {
		var oxygenBitPosition = 1;
		var oxygenGeneratorBytes = getPuzzleInputAsArray();
		while ( oxygenGeneratorBytes.len() > 1 ) {
			var mostCommonBit = findMostCommonBit( oxygenGeneratorBytes, oxygenBitPosition );
			param mostCommonBit = 1;
			oxygenGeneratorBytes = oxygenGeneratorBytes.filter( ( byte ) => {
				return byte.listToArray( "" )[ oxygenBitPosition ] == mostCommonBit;
			} );
			oxygenBitPosition++;
		}
		oxygenGeneratorBinary = oxygenGeneratorBytes[ 1 ];

		var co2BitPosition = 1;
		var co2ScrubberBytes = getPuzzleInputAsArray();
		while ( co2ScrubberBytes.len() > 1 ) {
			var leastCommonBit = findLeastCommonBit( co2ScrubberBytes, co2BitPosition );
			param leastCommonBit = 0;
			co2ScrubberBytes = co2ScrubberBytes.filter( ( byte ) => {
				return byte.listToArray( "" )[ co2BitPosition ] == leastCommonBit;
			} );
			co2BitPosition++;
			print.toConsole();
		}
		co2ScrubberBinary = co2ScrubberBytes[ 1 ];

		print.white( "Oxygen Generator Rating (binary): " ).greenLine( oxygenGeneratorBinary );
		var oxygenGeneratorRating = parseNumber( oxygenGeneratorBinary, "bin" );
		print.white( "Oxygen Generator Rating (decimal): " ).greenLine( oxygenGeneratorRating ).line();
		print.white( "CO2 Scrubber Rating (binary): " ).greenLine( co2ScrubberBinary );
		var co2ScrubberRating = parseNumber( co2ScrubberBinary, "bin" );
		print.white( "CO2 Scrubber Rating (decimal): " ).greenLine( co2ScrubberRating ).line();

		var answer = oxygenGeneratorRating * co2ScrubberRating;

		print.white( "Answer: " ).green( "#oxygenGeneratorRating# x #co2ScrubberRating# = " ).boldBlueLine( answer );
	}

	function findMostCommonBit( bytes, position ) {
		var diff = arguments.bytes.reduce( ( d, byte ) => {
			return d + ( byte.listToArray( "" )[ position ] == 0 ? -1 : 1 );
		}, 0 );
		return diff > 0 ? 1 : ( diff < 0 ? 0 : nullValue() );
	}

	function findLeastCommonBit( bytes, position ) {
		var diff = arguments.bytes.reduce( ( d, byte ) => {
			return d + ( byte.listToArray( "" )[ position ] == 0 ? -1 : 1 );
		}, 0 );
		return diff > 0 ? 0 : ( diff < 0 ? 1 : nullValue() );
	}

// 	function getPuzzleInput() {
// 		return "00100
// 11110
// 10110
// 10111
// 10101
// 01111
// 00111
// 11100
// 10000
// 11001
// 00010
// 01010";
// 	}

}
