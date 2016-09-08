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
// BY THE STUDENT IN ORDER TO PROVIDE A SOLUTION TO PROBLEM 2
//
// THE "ExampleProcess" CLASS SHOULD BE USED AS A GUIDE IN CREATING
// THE IMPLEMENTATION.
//
class Q2Process extends DatabaseProcess {

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
	
	static private int NUM_PROBLEMS;
	static private final String QUERY_For_NUM_PROBLEMS = "select count(*) as num_problems from problems";
	
	static private final String Q2Query = "SELECT p.id as person_id, p.last_name, p.first_name, p.postal, a.problem_id, a.answer, pro.truth "
															+ "FROM people p, attempts a, "
															+ "(SELECT id, "
															+ "case operator "
															+ "when '+' then arg1 + arg2 "
															+ "when '-' then arg1 - arg2 "
															+ "when '*' then arg1 * arg2 "
															+ "when '/' then arg1 / arg2 "
															+ "else 0 end as truth "
															+ "FROM problems) pro "
															+ "WHERE p.id = a.person_id and a.problem_id = pro.id "
															+ "order by p.postal";
	
	private List<QueryRow> query_rows = new ArrayList<QueryRow>();
	
	//Results of the Q2 query
	private List<Q2Result> q2results = new ArrayList<Q2Result>();
	
	private class QueryRow{
		
		//From database
		private int person_id;
		private String lname;
		private String fname;
		private String postal;
		private int problem_id;
		private int answer;
		private int truth;
		
		QueryRow(ResultSet results) throws SQLException {
			
			person_id = results.getInt("person_id");
			lname = results.getString("last_name");
			fname = results.getString("first_name");
			postal = results.getString("postal");
			problem_id = results.getInt("problem_id");
			answer = results.getInt("answer");
			truth = results.getInt("truth");
			
			query_rows.add(this);
			
		}
	}

	private class Q2Result{
		
		private int person_id;
		private String lname;
		private String fname;
		private String postcode;
		private int num_answered = 0;
		private int num_correctly = 0;

		// output to console
		public String toString() {

			return 	lname
					+" "+fname
					+" "+postcode
					+" "+num_answered
					+" "+ (num_answered == 0 ? 0 : (num_answered*100/NUM_PROBLEMS))
					+"% "+num_correctly
					+" "+(num_answered == 0 ? 0 : (num_correctly*100/num_answered))
					+"% "+(num_answered == 0 ? 0 : (num_correctly*100/NUM_PROBLEMS))+"% ";
		}

		// Construct result objects form the query results, add them to array list
		Q2Result(QueryRow row){
			boolean isNew = true;
			
			this.person_id = row.person_id;
			this.lname = row.lname;
			this.fname = row.fname;
			this.postcode = row.postal;
			
			if( !q2results.isEmpty() ){
				for( int i=0; i<q2results.size(); i++ ){
					Q2Result qr = q2results.get(i);
					if(qr.person_id == this.person_id){
						qr.num_answered += 1;
						if(row.answer == row.truth) qr.num_correctly += 1;
						isNew = false;
					}
				}
			}
			if(isNew){
				this.num_answered += 1;
				if(row.answer == row.truth) this.num_correctly += 1;
				q2results.add(this);
			}
		}

		// Render problem as a line in the output CSV file
		void print(CSVPrinter printer) throws IOException {		
			
			System.out.println("RETRIEVED: " + this);
			printer.printRecord(lname, fname, postcode, 
					num_answered, (num_answered == 0 ? 0 : (num_answered*100/NUM_PROBLEMS)), 
					num_correctly, (num_answered == 0 ? 0 : (num_correctly*100/num_answered)), (num_answered == 0 ? 0 : (num_correctly*100/NUM_PROBLEMS)) );
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
		
		//query the num of problems
		ResultSet pro_num = database.executeQuery(QUERY_For_NUM_PROBLEMS);
		while(pro_num.next()){
			NUM_PROBLEMS = pro_num.getInt("num_problems");
		}
		
		//query list of people with answer and problem's answer
		ResultSet results = database.executeQuery(Q2Query);
		while (results.next()){
			new QueryRow(results);
		}
		//calculate the num and percentage
		for(QueryRow row : query_rows){
			new Q2Result(row);
		}
		
		//sort by postcode and the correct perc
		sort(q2results);
		
	}

	private void sort(List<Q2Result> results) {
		//sort results by postal and then the correct perc
		Q2Result temp;
		for(int i=0; i<results.size()-1; i++){
			
			for(int j=1; j<results.size()-i; j++){
				//equal in postal
				if( results.get(j).postcode.equals(results.get(j-1).postcode) ){
					
					//sort by answered correctly from answered
					float percent1 = (results.get(j).num_correctly)*100/(results.get(j).num_answered);
					float percent2 = (results.get(j-1).num_correctly)*100/(results.get(j-1).num_answered);
					if (percent2 > percent1){
						temp = results.get(j-1);
						results.set(j-1, results.get(j));
						results.set(j, temp);
					}else if(percent2 == percent1){ //equal in answered correctly from answered
						
						//sort by answered correctly from total
						percent1 = ( (results.get(j).num_correctly)*100/NUM_PROBLEMS );
						percent2 = ( (results.get(j-1).num_correctly)*100/NUM_PROBLEMS );
						if (percent2 > percent1){
							temp = results.get(j-1);
							results.set(j-1, results.get(j));
							results.set(j, temp);
						}
					}
					
				}else{ //sort by poastal
					String post1 = results.get(j).postcode;
					String post2 = results.get(j-1).postcode;
					if(post1.compareTo(post2) < 0 ){
						temp = results.get(j-1);
						results.set(j-1, results.get(j));
						results.set(j, temp);
					}
				}
			}
		}
		
	}
	
	// Implementation of the "writeOutput" method as specified by the base-class.
	protected void writeOutput() throws IOException {
		File outCSVFile = getOutputFile();
		
		CSVPrinter printer = csvHandler.createPrinter(outCSVFile);
		
		for(Q2Result result : q2results) {
			result.print(printer);
		}
		


	}

	
	// Constructor.
	Q2Process(Database database, CSVHandler csvHandler) {
		this.database = database;
		this.csvHandler = csvHandler;
	}
}
