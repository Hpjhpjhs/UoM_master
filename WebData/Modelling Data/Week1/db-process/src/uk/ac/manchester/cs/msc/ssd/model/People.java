package uk.ac.manchester.cs.msc.ssd.model;

import java.sql.SQLException;

import uk.ac.manchester.cs.msc.ssd.core.Database;

public class People {

	//people table
	static private final String PEOPLE_TABLE_NAME = "PEOPLE";
	
	//people table columns
	static private final String PEOPLE_ID_NAME = "ID";
	static private final String PEOPLE_FIRST_NAME_NAME = "FIRST_NAME";
	static private final String PEOPLE_LAST_NAME_NAME = "LAST_NAME";
	static private final String PEOPLE_COMPANY_NAME = "COMPANY_NAME";
	static private final String PEOPLE_ADDRESS_NAME = "ADDRESS";
	static private final String PEOPLE_CITY_NAME = "CITY";
	static private final String PEOPLE_COUNTY_NAME = "COUNTY";
	static private final String PEOPLE_POSTAL_NAME = "POSTAL";
	static private final String PEOPLE_PHONE1_NAME = "PHONE1";
	static private final String PEOPLE_PHONE2_NAME = "PHONE2";
	static private final String PEOPLE_EMAIL_NAME = "EMAIL";
	static private final String PEOPLE_WEB_NAME = "WEB";

	//Arguements for creater PEOPLE table
	static private final String PEOPLE_TABLE_CREATION_ARGS
									= PEOPLE_ID_NAME + " integer NOT NULL, "
									+ PEOPLE_FIRST_NAME_NAME + " varchar(30) NOT NULL, "
									+ PEOPLE_LAST_NAME_NAME + " varchar(30) NOT NULL, "
									+ PEOPLE_COMPANY_NAME + " varchar(100), "
									+ PEOPLE_ADDRESS_NAME + " varchar(50), "
									+ PEOPLE_CITY_NAME + " varchar(30), "
									+ PEOPLE_COUNTY_NAME + " varchar(30), "
									+ PEOPLE_POSTAL_NAME + " varchar(30), "
									+ PEOPLE_PHONE1_NAME + " varchar(20), "
									+ PEOPLE_PHONE2_NAME + " varchar(20), "
									+ PEOPLE_EMAIL_NAME + " varchar(50), "
									+ PEOPLE_WEB_NAME + " varchar(50)";

	public People(){}
	
	public void createTable(Database database) throws SQLException{
		// Create "PROBLEMS" table in database
		database.createTable(PEOPLE_TABLE_NAME, PEOPLE_TABLE_CREATION_ARGS);
	}

	public static String getPeopleTableName() {
		return PEOPLE_TABLE_NAME;
	}

	public static String getPeopleIdName() {
		return PEOPLE_ID_NAME;
	}

	public static String getPeopleFirstNameName() {
		return PEOPLE_FIRST_NAME_NAME;
	}

	public static String getPeopleLastNameName() {
		return PEOPLE_LAST_NAME_NAME;
	}

	public static String getPeopleCompanyName() {
		return PEOPLE_COMPANY_NAME;
	}

	public static String getPeopleAddressName() {
		return PEOPLE_ADDRESS_NAME;
	}

	public static String getPeopleCityName() {
		return PEOPLE_CITY_NAME;
	}

	public static String getPeopleCountyName() {
		return PEOPLE_COUNTY_NAME;
	}

	public static String getPeoplePostalName() {
		return PEOPLE_POSTAL_NAME;
	}

	public static String getPeoplePhone1Name() {
		return PEOPLE_PHONE1_NAME;
	}

	public static String getPeoplePhone2Name() {
		return PEOPLE_PHONE2_NAME;
	}

	public static String getPeopleEmailName() {
		return PEOPLE_EMAIL_NAME;
	}

	public static String getPeopleWebName() {
		return PEOPLE_WEB_NAME;
	}
	
	
	
}
