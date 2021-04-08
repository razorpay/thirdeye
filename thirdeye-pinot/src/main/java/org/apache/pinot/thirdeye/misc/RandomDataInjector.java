package org.apache.pinot.thirdeye.misc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.util.ArrayList;

public class RandomDataInjector {

	static final String JDBC_DRIVER = "org.postgresql.Driver";
	static final String DB_URL = "jdbc:postgresql://localhost:5432/thirdeye";

	// Database credentials
	static final String USER = "thirdeye";
	static final String PASS = "root";
	static final String TABLE_NAME = "success_rate";

	public static void main(String[] args) {
		Connection conn = null;
		Statement stmt = null;
		ArrayList<String> paymentMethods = new ArrayList<>();
		paymentMethods.add("Prepaid Card");
		paymentMethods.add("Debit Card");
		paymentMethods.add("wallet");
		paymentMethods.add("nach");
		paymentMethods.add("UPI Collect");
		paymentMethods.add("Credit Card");
		paymentMethods.add("paylater");
		paymentMethods.add("UPI Intent");
		paymentMethods.add("netbanking");
		paymentMethods.add("UPI Unknown");
		paymentMethods.add("emandate");
		paymentMethods.add("Unknown Card");
		paymentMethods.add("cardless_emi");
		try {
			Class.forName("com.mysql.jdbc.Driver");
			System.out.println("Connecting to a selected database...");
			conn = DriverManager.getConnection(DB_URL, USER, PASS);
			System.out.println("Inserting records into the table.");
			stmt = conn.createStatement();

			String dateStr, sql;
			float sr = 0;
			LocalDateTime date = LocalDateTime.now().minusMinutes(20);
			for (int i = 1; i <= 30; i++) {
				if (i == 11) {
					date = LocalDateTime.now().minusMinutes(10);
				}
				if (i == 21) {
					date = LocalDateTime.now();
				}
				if (i < 10) {
					sr = (float) Math.random();
				} else if (i > 10 && i <= 20) {
					sr = (float) 8;
				} else if (i > 20) {
					sr = (float) Math.random();
				}
				date = date.plusMinutes(1);
				dateStr = date.toString().replace('T', ' ').substring(0, 19);
				sql = String.format(
						"insert into %s (payment_method, minute, sr) VALUES ('"
								+ paymentMethods.get((int) (Math.random() * 12)) + "','" + dateStr + "', " + sr + ");",
						TABLE_NAME);
				stmt.executeUpdate(sql);
				System.out.println(i + " : " + sr);
			}
		} catch (SQLException se) {
			se.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null)
					conn.close();
			} catch (SQLException se) {}
			try {
				if (conn != null)
					conn.close();
			} catch (SQLException se) {
				se.printStackTrace();
			}
		}
		System.out.println("Done");
	}
}