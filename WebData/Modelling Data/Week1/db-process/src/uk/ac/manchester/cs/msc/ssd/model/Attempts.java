package uk.ac.manchester.cs.msc.ssd.model;

import java.sql.SQLException;

import uk.ac.manchester.cs.msc.ssd.core.Database;

public class Attempts {

	//attempts table
	static private final String ATTEMPTS_TABLE_NAME = "ATTEMPTS";
	
	//attempts table columns
	static private final String PERSON_ID_NAME = "PERSON_ID";
	static private final String PROBLEM_ID_NAME = "PROBLEM_ID";
	static private final String ANSWER_NAME = "ANSWER";

	//Arguements for creater PEOPLE table
	static private final String ATTEMPTS_TABLE_CREATION_ARGS
									= PERSON_ID_NAME + " integer NOT NULL, "
									+ PROBLEM_ID_NAME + " integer NOT NULL, "
									+ ANSWER_NAME + " integer NOT NULL";

	public Attempts(){}
	
	public void createTable(Database database) throws SQLException{
		// Create "PROBLEMS" table in database
		database.createTable(ATTEMPTS_TABLE_NAME, ATTEMPTS_TABLE_CREATION_ARGS);
	}

	public static String getAttemptsTableName() {
		return ATTEMPTS_TABLE_NAME;
	}

	public static String getPersonIdName() {
		return PERSON_ID_NAME;
	}

	public static String getProblemIdName() {
		return PROBLEM_ID_NAME;
	}

	public static String getAnswerName() {
		return ANSWER_NAME;
	}

	
}
