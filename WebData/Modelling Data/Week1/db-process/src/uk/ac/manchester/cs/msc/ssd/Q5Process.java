package uk.ac.manchester.cs.msc.ssd;

import java.io.*;
import java.sql.*;
import java.util.*;

import org.apache.commons.csv.*;

import uk.ac.manchester.cs.msc.ssd.core.*;

//
// THIS CLASS IS A TEMPLATE WHOSE IMPLEMENTATION SHOULD BE PROVIDED
// BY THE STUDENT IN ORDER TO PROVIDE A SOLUTION TO PROBLEM 1.
//
// THE "ExampleProcess" CLASS SHOULD BE USED AS A GUIDE IN CREATING
// THE IMPLEMENTATION.
//
class Q5Process extends DatabaseProcess {

	private Database database;
	private CSVHandler csvHandler;

	
	static private final String Q5Query = "SELECT a1.person_id as p1, a2.person_id as p2, a1.answer "
									+ "FROM ATTEMPTS a1, ATTEMPTS a2 "
									+ "WHERE a1.answer = a2.answer "
									+ "and a1.problem_id = a2.problem_id "
									+ "and a1.person_id <> a2.person_id ";
	
	private List<Q5Result> query_results = new ArrayList<Q5Result>();
	
	private class Q5Result {
		
		private int p1_id;
		private int p2_id;
		private int answer;
		
		
		// output to console
		public String toString() {

			return "SAME ATTEMPTS- "+p1_id +" "+p2_id +" "+answer;
		}

		// Construct result objects form the query results, add them to array list
		Q5Result(ResultSet results) throws SQLException {

			
			p1_id = results.getInt("p1");
			p2_id = results.getInt("p2");
			answer = results.getInt("answer");
			
			query_results.add(this);

			System.out.println("RETRIEVED: " + this);
		}

		// Render problem as a line in the output CSV file
		void print(CSVPrinter printer) throws IOException {
			printer.printRecord(p1_id, p2_id, answer);
		}
		
		
	}
	
	// Implementation of the "readInput" method as specified by the base-class.
	protected void readInput() throws IOException {

		System.out.println("readInput(): Method to be implemented");
	}

	// Implementation of the "runCoreProcess" method as specified by the base-class.
	protected void runCoreProcess() throws SQLException {
		
		ResultSet results = database.executeQuery(Q5Query);
		
		while (results.next()){
			
			new Q5Result(results);
			
		}
	}

	// Implementation of the "writeOutput" method as specified by the base-class.
	protected void writeOutput() throws IOException {

		System.out.println("writeOutput(): Method to be implemented");
	}

	// Constructor.
	Q5Process(Database database, CSVHandler csvHandler) {

		this.database = database;
		this.csvHandler = csvHandler;
	}
}
