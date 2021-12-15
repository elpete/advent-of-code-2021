component {

    variables.sessionId = "53616c7465645f5fe3b002fe2e104a58d1bb97d3bfa5f7a0517a12fc6c0399165782e83a477ec05ca4d38dbc2a2e9d9c";

    public void function preTask() {
        loadModule( "../modules/hyper" );
    }

    public string function getPuzzleInput() {
		return getInstance( "HyperRequest@hyper" )
			.withHeaders( {
				"Cookie": "session=#variables.sessionId#"
			} )
			.get( "https://adventofcode.com/2021/day/#getPuzzleNumber()#/input" )
            .getData();
	}

    public array function listSplit( required string list, required string pattern ) {
        return arraySlice( arguments.list.split( arguments.pattern ), 1 );
    }

    public array function getPuzzleInputAsArray( string delimiter = "\n" ) {
        return arraySlice( getPuzzleInput().split( arguments.delimiter ), 1 );
    }

	public numeric function getPuzzleNumber() {
		return replaceNoCase( listGetAt( getCurrentTemplatePath(), listLen( getCurrentTemplatePath(), "/" ) - 1, "/" ), "day", "" );
	}

}