package mytest;

import mytest.hibernate.HibernateInterceptor;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

import com.poc.common.entities.UserProfile;
import com.poc.utils.util.DateUtil;

/**
 * Target : Created By : jiyun Createzd Date : 2011-5-6 Version : Remarks :
 */
public class TestHibernate {
	private static SessionFactory sessionFactory = null;

	public static void main(String[] args) {
		try {
			// Create the SessionFactory from hibernate.cfg.xml
			sessionFactory = new Configuration().setInterceptor(
					new HibernateInterceptor()).configure("hibernate.cfg.xml")
					.buildSessionFactory();

			Session session = sessionFactory.openSession();
			Transaction tx = session.beginTransaction();			
			for(int i=0;i<50;i++){
				UserProfile person = new UserProfile();
				person.setFirstName("john");
				person.setLastName("Test");
				person.setGender("M");
				person.setDob(DateUtil.parseDate("1984/09/09","yyyy/MM/dd"));
				person.setEmail("jiyun2010@gmail.com");
				person.setMobileNumber("12345678");
				session.save(person);
				session.flush();
				session.clear();
			}
			tx.commit();
			session.close();

			sessionFactory.close();

		} catch (Throwable ex) {
			// Make sure you log the exception, as it might be swallowed
			System.err.println("Initial SessionFactory creation failed." + ex);
			throw new ExceptionInInitializerError(ex);
		}

	}

}
