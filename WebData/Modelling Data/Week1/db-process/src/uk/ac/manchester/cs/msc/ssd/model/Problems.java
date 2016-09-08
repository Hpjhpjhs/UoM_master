package uk.ac.manchester.cs.msc.ssd.model;

import java.io.File;
import java.sql.SQLException;

import uk.ac.manchester.cs.msc.ssd.core.Database;

public class Problems {
	


	// Name of "PROBLEMS" table
	static private final String PROBLEMS_TABLE_NAME = "PROBLEMS";

	// Names of columns for "PROBLEMS" table
	static private final String PROBLEM_ID_NAME = "ID";
	static private final String PROBLEM_OP_NAME = "OPERATOR";
	static private final String PROBLEM_ARG1_NAME = "ARG1";
	static private final String PROBLEM_ARG2_NAME = "ARG2";

	// Arguments for "CREATE TABLE ..." command that will create
	// "PROBLEMS" table
	static private final String PROBLEMS_TABLE_CREATION_ARGS
									= PROBLEM_ID_NAME + " integer NOT NULL, "
									+ PROBLEM_ARG1_NAME + " integer NOT NULL, "
									+ PROBLEM_OP_NAME + " char(1), "
									+ PROBLEM_ARG2_NAME + " integer NOT NULL";
	
	// Query for selecting everything from "PROBLEMS" table
	static private final String SELECT_ALL_PROBLEMS_QUERY
									= "SELECT * FROM "
									+ PROBLEMS_TABLE_NAME;
	
	public Problems(){}
	
	public void createTable(Database database) throws SQLException{
		// Create "PROBLEMS" table in database
		database.createTable(PROBLEMS_TABLE_NAME, PROBLEMS_TABLE_CREATION_ARGS);
	}

	public static String getProblemsTableName() {
		return PROBLEMS_TABLE_NAME;
	}

	public static String getProblemIdName() {
		return PROBLEM_ID_NAME;
	}

	public static String getProblemOpName() {
		return PROBLEM_OP_NAME;
	}

	public static String getProblemArg1Name() {
		return PROBLEM_ARG1_NAME;
	}

	public static String getProblemArg2Name() {
		return PROBLEM_ARG2_NAME;
	}

	
	
//	public List<Problems> queryAll() throws SQLException{
//		
//		// Execute query to select everything from the "PROBLEMS" table
//		ResultSet results = database.executeQuery(SELECT_ALL_PROBLEMS_QUERY);
//
//		// Save query results as array of Problems objects
//		while (results.next()) {
//
//			// Construct Problem object and add it to the array
//			// (the adding is done by the Problem constructor)
//			//new Problem(results);
//		}
//		return null;
//	}

}
