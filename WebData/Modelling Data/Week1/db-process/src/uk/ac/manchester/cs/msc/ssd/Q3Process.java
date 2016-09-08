package uk.ac.manchester.cs.msc.ssd;

import java.io.*;
import java.sql.*;
import java.util.*;

import org.apache.commons.csv.*;

import uk.ac.manchester.cs.msc.ssd.core.*;
import uk.ac.manchester.cs.msc.ssd.model.Attempts;
import uk.ac.manchester.cs.msc.ssd.model.People;
import uk.ac.manchester.cs.msc.ssd.model.Problems;

//
// THIS CLASS IS A TEMPLATE WHOSE IMPLEMENTATION SHOULD BE PROVIDED
// BY THE STUDENT IN ORDER TO PROVIDE A SOLUTION TO PROBLEM 3.
//
// THE "ExampleProcess" CLASS SHOULD BE USED AS A GUIDE IN CREATING
// THE IMPLEMENTATION.
//
class Q3Process extends DatabaseProcess {

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

	//problems.csv
	static private final File PROBLEMS_IN_FILE = getInputFile("problems");
	
	//read "problems.csv" file
	private InputTable problemsInputTable = new InputTable();

	static private final String Q3Query = "SELECT num.id, num.num_person, (corr.num_corr*100/num.num_person) as perc_corr "+
			"FROM "
			
			+ "(SELECT pro.id, count(a.person_id) as num_person "
			+ "FROM problems pro "
			+ "JOIN ATTEMPTS a on a.problem_id = pro.id "
			+ "group by pro.id) num, "
			
			+ "(SELECT pro.id, count(a.person_id) as num_corr "
			+ "FROM "
			+ "(SELECT pro.*, "
			+ "case pro.operator when '+' then pro.arg1 + pro.arg2 when '-' then pro.arg1 - pro.arg2 when '*' then pro.arg1 * pro.arg2 when '/' then pro.arg1 / pro.arg2 else 0 end as answer "
			+ "FROM problems pro ) pro "
			+ "JOIN ATTEMPTS a on a.problem_id = pro.id "
			+ "Where a.answer = pro.answer "
			+ "group by pro.id) corr "
			
			+ "WHERE corr.id = num.id";
	
	
	//Results of the Q3 query
	private List<Q3Result> query_results = new ArrayList<Q3Result>();
	
	private class Q3Result{
		
		private int pro_id;
		private int num_person;
		private float perc_corr;
		
		// output to console
		public String toString() {

			return "Problems Answered- "+pro_id +" "+num_person +" "+perc_corr;
		}

		// Construct result objects form the query results, add them to array list
		Q3Result(ResultSet results) throws SQLException {

			
			pro_id = results.getInt("id");
			num_person = results.getInt("num_person");
			perc_corr = results.getFloat("perc_corr");
			
			query_results.add(this);

			System.out.println("RETRIEVED: " + this);
		}

		// Render problem as a line in the output CSV file
		void print(CSVPrinter printer) throws IOException {
			printer.printRecord(pro_id, num_person, perc_corr);
		}
	}
	
	// Implementation of the "readInput" method as specified by the base-class.
	protected void readInput() throws IOException {
		//read people file
		peopleInputTable.readFromFile(csvHandler, PEOPLE_IN_FILE);
		//read attempts file
		attemptsInputTable.readFromFile(csvHandler, ATTEMPTS_IN_FILE);
		//read problems file
		problemsInputTable.readFromFile(csvHandler, PROBLEMS_IN_FILE);
	}

	// Implementation of the "runCoreProcess" method as specified by the base-class.
	protected void runCoreProcess() throws SQLException {
		People peoTable = new People();
		Attempts attemTable = new Attempts();
		Problems probTable = new Problems();
		
		//create people table
		peoTable.createTable(this.database);
		//create attempts table
		attemTable.createTable(this.database);
		//create problesm table
		probTable.createTable(this.database);
		
		//write people.csv into people table
		peopleInputTable.writeToDatabase(database, peoTable.getPeopleTableName());
		//write attempts.csv into attempts table
		attemptsInputTable.writeToDatabase(database, attemTable.getAttemptsTableName());
		//wirte problems.csv into problem table
		problemsInputTable.writeToDatabase(database, probTable.getProblemsTableName());

		ResultSet results = database.executeQuery(Q3Query);
		
		while (results.next()){
			
			new Q3Result(results);
			
		}
	}

	// Implementation of the "writeOutput" method as specified by the base-class.
	protected void writeOutput() throws IOException {
		File outCSVFile = getOutputFile();
		
		CSVPrinter printer = csvHandler.createPrinter(outCSVFile);
		
		for(Q3Result result : query_results) {
			result.print(printer);
		}
	}

	// Constructor.
	Q3Process(Database database, CSVHandler csvHandler) {

		this.database = database;
		this.csvHandler = csvHandler;
	}
}
