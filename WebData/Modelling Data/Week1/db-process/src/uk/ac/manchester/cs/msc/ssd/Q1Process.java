package uk.ac.manchester.cs.msc.ssd;

import java.io.*;
import java.sql.*;
import java.util.*;

import org.apache.commons.csv.*;

import uk.ac.manchester.cs.msc.ssd.core.*;
import uk.ac.manchester.cs.msc.ssd.model.Attempts;
import uk.ac.manchester.cs.msc.ssd.model.People;

//
// THIS CLASS IS A TEMPLATE WHOSE IMPLEMENTATION SHOULD BE PROVIDED
// BY THE STUDENT IN ORDER TO PROVIDE A SOLUTION TO PROBLEM 1.
//
// THE "ExampleProcess" CLASS SHOULD BE USED AS A GUIDE IN CREATING
// THE IMPLEMENTATION.
//
class Q1Process extends DatabaseProcess {

	private Database database;
	private CSVHandler csvHandler;

	//people.csv
	static private final File PEOPLE_IN_FILE = getInputFile("people");
	
	//read "people.csv" file
	private InputTable peopleInputTable =  new InputTable();
	
	//attemtps.csv
	static private final File ATTEMPTS_IN_FILE = getInputFile("attempts");
	
	//read "attempts.csv" file
	private InputTable attemptsInputTable =  new InputTable();

	
	//Query
	//query result column for the number of problems answered
	static private final String NUM_PROBLEM_ANSWERED_NAME = "NUM_ANSWERED";
	static private final String LNAME = "last_name";
	static private final String FNAME = "first_name";
	
	//Query for select three columns from "PEOPLE" and "ATTEMPTS" tables
	static private final String Q1Query = "SELECT p.last_name, p.first_name, count(a.person_id) as num_answered "
												+"FROM people p, attempts a "
												+"WHERE p.id = a.person_id "
												+ "GROUP BY p.last_name, p.first_name";
	
	//Results of the Q1 query
	private List<Q1Result> query_results = new ArrayList<Q1Result>();
	
	private class Q1Result{
		 
		private String lname;
		private String fname;
		private int num;
		
		// output to console
		public String toString() {

			return "last name: "+lname
					+", first name: "+fname
					+", number of problems answered: "+num;
		}

		// Construct result objects form the query results, add them to array list
		Q1Result(ResultSet results) throws SQLException {

			lname = results.getString(LNAME);
			fname = results.getString(FNAME);
			num = results.getInt(NUM_PROBLEM_ANSWERED_NAME);

			query_results.add(this);

			System.out.println("RETRIEVED: " + this);
		}

		// Render problem as a line in the output CSV file
		void print(CSVPrinter printer) throws IOException {
			printer.printRecord(lname, fname, num);
		}
	}
	
	
	// Implementation of the "readInput" method as specified by the base-class.
	protected void readInput() throws IOException {
		//read people file
		peopleInputTable.readFromFile(csvHandler, PEOPLE_IN_FILE);
		//read attempts file
		attemptsInputTable.readFromFile(csvHandler, ATTEMPTS_IN_FILE);
	}

	// Implementation of the "runCoreProcess" method as specified by the base-class.
	protected void runCoreProcess() throws SQLException {
		
		People peoTable = new People();
		Attempts attemTable = new Attempts();
		
		//create people table
		peoTable.createTable(this.database);
		//create attempts table
		new Attempts().createTable(database);
		
		//write people.csv into people table
		peopleInputTable.writeToDatabase(database, peoTable.getPeopleTableName());
		//write attempts.csv into attempts table
		attemptsInputTable.writeToDatabase(database, attemTable.getAttemptsTableName());

		//execute Q1 query
		ResultSet results = database.executeQuery(Q1Query);
		while(results.next()){
			new Q1Result(results);
		}
	}

	// Implementation of the "writeOutput" method as specified by the base-class.
	protected void writeOutput() throws IOException {
		
		File outCSVFile = getOutputFile();

		//print results into "Q1Process.csv" file
		CSVPrinter printer = csvHandler.createPrinter(outCSVFile);
		
		// print each result as a line into csv file
		for (Q1Result result : query_results) {

			result.print(printer);
		}
	}

	// Constructor.
	Q1Process(Database database, CSVHandler csvHandler) {

		this.database = database;
		this.csvHandler = csvHandler;
	}
}
