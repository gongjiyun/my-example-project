package com.xxooframe.utils.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.TimeZone;

public class DateUtil {

	public static String formatDate(Date date, String pattern, boolean exception)
			throws Exception {
		try {
			DateFormat df = new SimpleDateFormat(pattern);
			String str = df.format(date);
			return str;
		} catch (Exception e) {
			e.printStackTrace();
			if (exception) {
				throw e;
			}
		}
		return null;
	}
	
	public static Date parseDate(String dataStr, String formatStr) {

		Date date = null;
		SimpleDateFormat sdf = new SimpleDateFormat(formatStr, Locale.ENGLISH);
		try {
			if (dataStr != null && formatStr != null && dataStr.trim().length() > 0 && formatStr.trim().length() > 0) {

				date = sdf.parse(dataStr);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return date;
	}
	
	public static Date parseDate(String dataStr, String formatStr, boolean exception) throws Exception{

		Date date = null;
		SimpleDateFormat sdf = new SimpleDateFormat(formatStr);
		try {
			if (dataStr != null && formatStr != null && dataStr.trim().length() > 0 && formatStr.trim().length() > 0) {

				date = sdf.parse(dataStr);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			if (exception) {
				throw e;
			}
		}
		return date;
	}

	public static Date addDays(Date date, int days) {

		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.DATE, days);
		return calendar.getTime();
	}
	
	public static Date addHrs(Date date, int hrs) {

		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.HOUR, hrs);
		return calendar.getTime();
	}

	public static Date RemoveDays(Date date, int days) {

		return addDays(date, -1 * days);
	}

	public static Date getFirstDayOfMonth() {

		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DAY_OF_MONTH, 1);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTime();
	}

	public static Date getFirstDayByDate(Date date) {

		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTime();
	}

	public static String convertDates(String frmdateStr, String frmFormatStr, String toFormatStr)
		throws ParseException {

		SimpleDateFormat frmFormatter = new SimpleDateFormat(frmFormatStr);
		Date date = frmFormatter.parse(frmdateStr);
		SimpleDateFormat toFormatter = new SimpleDateFormat(toFormatStr);
		return toFormatter.format(date);
	}

	public static String formatDate(Date date, Locale locale) {

		SimpleDateFormat df = new SimpleDateFormat("EEEE dd-MMM-yyyy, hh:mm a, Z", locale);
		String formatDateStr = df.format(date);
		try {
			// formatDateStr =
			// formatDateStr.substring(0,formatDateStr.length()-2);
			formatDateStr = formatDateStr.replace("+", "GMT+");
		}
		catch (Exception e) {

		}

		return formatDateStr;
	}

	public static String formatDate(Date date, TimeZone timezone) {

		/*
		 * SimpleDateFormat df = new
		 * SimpleDateFormat("EEEE dd-MMM-yyyy, hh:mm a, Z", locale); String
		 * formatDateStr = df.format(date); try{ //formatDateStr =
		 * formatDateStr.substring(0,formatDateStr.length()-2);
		 * formatDateStr=formatDateStr.replace("+", "GMT+"); }catch(Exception
		 * e){ }
		 */

		/*
		 * DateFormat formatter= new SimpleDateFormat("MM/dd/yyyy HH:mm:ss Z");
		 * formatter.setTimeZone(TimeZone.getTimeZone("Europe/London"));
		 * System.out.println(formatter.format(date));
		 * formatter.setTimeZone(TimeZone.getTimeZone("Europe/Athens"));
		 * System.out.println(formatter.format(instance2.getTime()))
		 */
		return "";
	}

	/**
	 * get current month
	 * 
	 * @return
	 */
	public static int getCurrentMonthActualMaximumDays() {

		Calendar cal = Calendar.getInstance();
		return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	}

	public static int getLastMonthActualMaximumDaysByDate(Date date) {

		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.set(Calendar.MONTH, cal.get(Calendar.MONTH) - 1);
		return cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	}

	/**
	 * This method is used to get perpetual date
	 * 
	 * @return Perpetual date
	 */
	public static Date getPerpetualDate() {

		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, 9999);
		cal.set(Calendar.MONTH, 11);
		cal.set(Calendar.DAY_OF_MONTH, 31);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTime();
	}

	public static boolean isAfterDaysExpired(int days, Date serviceEndDate) {

		Calendar calendar = Calendar.getInstance();
		calendar.add(Calendar.DAY_OF_MONTH, days);
		calendar.set(Calendar.HOUR_OF_DAY, 0);
		calendar.set(Calendar.MINUTE, 0);
		calendar.set(Calendar.SECOND, 0);
		calendar.set(Calendar.MILLISECOND, 0);

		Calendar endDate = Calendar.getInstance();
		endDate.setTime(serviceEndDate);
		endDate.set(Calendar.HOUR_OF_DAY, 0);
		endDate.set(Calendar.MINUTE, 0);
		endDate.set(Calendar.SECOND, 0);
		endDate.set(Calendar.MILLISECOND, 0);

		return calendar.after(endDate);
	}

	public static int getRestDaysOfMonth(Date date) {

		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		int days = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

		SimpleDateFormat sdf = new SimpleDateFormat("dd");
		int today = Integer.valueOf(sdf.format(date)).intValue();

		return days - today;
	}

	public static Date getLastDateOfMonth(Date date) {

		try {
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			int days = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

			String dateStr = formatDate(date, "yyyyMM") + "" + days;

			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			return sdf.parse(dateStr);
		}
		catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}

	public static boolean isBetweenSameMonthAndYear(Date start, Date end) {

		if (end==null) {
			return false;
		}
		Calendar startCal = Calendar.getInstance();
		startCal.setTime(start);
		Calendar endCal = Calendar.getInstance();
		endCal.setTime(end);
		int startCalYear = startCal.get(Calendar.YEAR);
		int startCalMonth = startCal.get(Calendar.MONTH);
		int endCalYear = endCal.get(Calendar.YEAR);
		int endCalMonth = endCal.get(Calendar.MONTH);
		if (startCalYear == endCalYear && startCalMonth == endCalMonth) {
			return true;
		}
		return false;
	}

	public static boolean isBetweenSameDayAndMonthAndYear(Date start, Date end) {

		if (end==null || start==null) {
			return false;
		}
		Calendar startCal = Calendar.getInstance();
		startCal.setTime(start);
		Calendar endCal = Calendar.getInstance();
		endCal.setTime(end);
		int startCalYear = startCal.get(Calendar.YEAR);
		int startCalMonth = startCal.get(Calendar.MONTH);
		int startCalDay = startCal.get(Calendar.DAY_OF_MONTH);
		int endCalYear = endCal.get(Calendar.YEAR);
		int endCalMonth = endCal.get(Calendar.MONTH);
		int endCalDay = endCal.get(Calendar.DAY_OF_MONTH);
		if (startCalYear == endCalYear && startCalMonth == endCalMonth && startCalDay == endCalDay) {
			return true;
		}
		return false;
	}

	/**
	 * This method is used to calculate the remaining days by date.<br /> e.g.
	 * start from 2014-12-28, end to 2014-12-31, the results should be 4 days,
	 * 28,,29,30,31
	 * 
	 * @param date
	 * @return
	 */
	public static int getRemainingDaysByDate(Date date) {

		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		int dayOfMonth = cal.get(Calendar.DAY_OF_MONTH);
		int dayOfActualMaximum = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
		return dayOfActualMaximum - dayOfMonth + 1;// plugs current day. e.g.
													// 28,29,30,31
	}
	
	public static boolean isFirstDayOfTheDate(Date date) {

		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		int dayOfMonth = cal.get(Calendar.DAY_OF_MONTH);
		if (dayOfMonth == 1) {
			return true;
		}
		return false;
	}

	public static int differenceBetweenTwoDates(Date date1, Date date2) {

		int diffInDays = (int) ((date1.getTime() - date2.getTime()) / (1000 * 60 * 60 * 24));

		return Math.abs(diffInDays);
	}

	public static final String formatDate(Date date, String formatPattern) {

		if (date == null || formatPattern == null) {
			return null;
		}

		SimpleDateFormat sdf = new SimpleDateFormat(formatPattern);

		return sdf.format(date);
	}

	/*
	 * ------------------------------------------------------------------ Use
	 * for JS DatePicker
	 * ------------------------------------------------------------------
	 */
	public static final String DEFAULT_JS_DATE_FORMAT = "dd/MM/yyyy";

	/**
	 * Get System current date in the format of "dd/MM/yyyy"
	 * 
	 * @return
	 */
	public static final String getSystemDate() {

		return getSystemDate(DEFAULT_JS_DATE_FORMAT);
	}

	/**
	 * One week after current date, this maps to '+1w' in JS datePicker
	 * 
	 * @return
	 */
	public static final String getSystemDatePlusOneWeek() {

		return getSystemDatePlusOneWeek(DEFAULT_JS_DATE_FORMAT);
	}

	/**
	 * Get System Date in the specified date format pattern
	 * 
	 * @param datePattern
	 * @return
	 */
	public static final String getSystemDate(String datePattern) {

		SimpleDateFormat sdf = new SimpleDateFormat(datePattern);

		String date = sdf.format(new Date());

		return date;
	}

	/**
	 * One Week after current date
	 * 
	 * @param datePattern
	 * @return
	 */
	public static final String getSystemDatePlusOneWeek(String datePattern) {

		SimpleDateFormat sdf = new SimpleDateFormat(datePattern);

		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.WEEK_OF_YEAR, 1);
		String date = sdf.format(cal.getTime());

		return date;
	}

	/**
	 * Get date range for datePick
	 * 
	 * @return
	 */
	public static final String getDateRangeToCurrentYear() {

		String range = "1800:";
		range += Calendar.getInstance().get(Calendar.YEAR);

		return range;
	}

	public static final Date getLastDateOfCurrentMonth() {

		Calendar c = Calendar.getInstance();
		c.set(Calendar.DATE, c.getActualMaximum(Calendar.DAY_OF_MONTH));

		return c.getTime();
	}

	public static final boolean isDateBetweenDateRange(Date date, Date startDate, Date endDate) {

		Calendar dateCal = Calendar.getInstance();
		dateCal.setTime(date);
		dateCal.set(Calendar.HOUR_OF_DAY, 0);
		dateCal.set(Calendar.MINUTE, 0);
		dateCal.set(Calendar.SECOND, 0);
		dateCal.set(Calendar.MILLISECOND, 0);

		Calendar startDateCal = Calendar.getInstance();
		startDateCal.setTime(startDate);
		startDateCal.set(Calendar.HOUR_OF_DAY, 0);
		startDateCal.set(Calendar.MINUTE, 0);
		startDateCal.set(Calendar.SECOND, 0);
		startDateCal.set(Calendar.MILLISECOND, 0);

		Calendar endDateCal = Calendar.getInstance();
		endDateCal.setTime(endDate);
		endDateCal.set(Calendar.HOUR_OF_DAY, 0);
		endDateCal.set(Calendar.MINUTE, 0);
		endDateCal.set(Calendar.SECOND, 0);
		endDateCal.set(Calendar.MILLISECOND, 0);

		if ((dateCal.getTimeInMillis() >= startDateCal.getTimeInMillis() && dateCal.getTimeInMillis() <= endDateCal.getTimeInMillis()) || dateCal.getTimeInMillis() == startDateCal.getTimeInMillis() ||
			dateCal.getTimeInMillis() == endDateCal.getTimeInMillis()) {
			return true;
		}
		return false;
	}


	public static boolean isFutureDate(Date date) {

		if (date==null) {
			return false;
		}
		Calendar nowCal = Calendar.getInstance();
		nowCal.set(Calendar.HOUR_OF_DAY, 0);
		nowCal.set(Calendar.MINUTE, 0);
		nowCal.set(Calendar.SECOND, 0);
		nowCal.set(Calendar.MILLISECOND, 0);
		Calendar dateCal = Calendar.getInstance();
		dateCal.setTime(date);
		dateCal.set(Calendar.MINUTE, 0);
		dateCal.set(Calendar.SECOND, 0);
		dateCal.set(Calendar.MILLISECOND, 0);
		if (nowCal.getTimeInMillis() < dateCal.getTimeInMillis()) {
			return true;
		}
		return false;
	}
}
