package service;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import entity.Talent;
import java.util.List;

import javax.persistence.EntityNotFoundException;

import java.util.Date;

@Service
public class TalentDao_usingHibernate {
	@Autowired // spring dependency injection
	private SessionFactory sessionFactory;

	@Transactional
	public Talent findById(int id) {
		Session currentSession = sessionFactory.getCurrentSession();
		return currentSession.get(Talent.class, id);
	}

	@Transactional(rollbackFor = Exception.class)
	public void save(Talent talent) {
		try {
			Session currentSession = sessionFactory.getCurrentSession();
			currentSession.saveOrUpdate(talent);
		} catch (Exception e) {
			throw new RuntimeException("Error saving talent: " + e.getMessage(), e);
		}
	}

	@Transactional
	public void detach(Talent talent) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.evict(talent);
	}

	@Transactional
	public void update(Talent talent) {
		Session currentSession = sessionFactory.getCurrentSession();

		// Retrieve the persistent Talent from the database using the provided id
		Talent existingTalent = currentSession.get(Talent.class, talent.getId());

		// Check if the Talent exists before updating
		if (existingTalent != null) {
			// Update the properties of the existing Talent with the new values
			existingTalent.setSchoolCode(talent.getSchoolCode());
			existingTalent.setSchoolName(talent.getSchoolName());
			existingTalent.setName(talent.getName());
			existingTalent.setGender(talent.getGender());
			existingTalent.setContact(talent.getContact());
			existingTalent.setEmail(talent.getEmail());
			existingTalent.setReason(talent.getReason());

			// No need to explicitly call save or merge, as Hibernate will track changes
		} else {
			throw new EntityNotFoundException("Talent with ID " + talent.getId() + " not found");
		}
	}

	@Transactional
	public void delete(int id) {
		Session currentSession = sessionFactory.getCurrentSession();
		// Retrieve the persistent customer from the database using the provided id
		Talent talentToDelete = currentSession.get(Talent.class, (int) id);
		// Check if the customer exists before deleting
		if (talentToDelete != null) {
			// Delete the customer from the database
			currentSession.delete(talentToDelete);
		}
	}

	@Transactional
	public List<Talent> findAll() {
		Session currentSession = sessionFactory.getCurrentSession();
		return currentSession.createQuery("from Talent", Talent.class).getResultList();
	}

	@Transactional
	public Talent findByEmail(String email) {
		try {
			Session session = sessionFactory.getCurrentSession();

			// Create HQL query to find talent by email
			String hql = "FROM Talent WHERE email = :email";
			Query<Talent> query = session.createQuery(hql, Talent.class);
			query.setParameter("email", email);

			// Return the unique result or null if not found
			return query.uniqueResult();

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	// Optional: Add a method to check if email exists
	public boolean emailExists(String email) {
		Talent talent = findByEmail(email);
		return talent != null;
	}

}