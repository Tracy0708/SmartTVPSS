package service;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import entity.Talent;
import java.util.List;
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

    @Transactional
    public void save(Talent talent) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.saveOrUpdate(talent);
    }

    @Transactional
    public void detach(Talent talent) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.evict(talent);
    }

    @Transactional
    public void update(int id, Talent talent) {
        Session currentSession = sessionFactory.getCurrentSession();
        // Retrieve the persistent customer from the database using the provided id
        Talent existingTalent = currentSession.get(Talent.class, (long) id);
        // Check if the customer exists before updating
        if (existingTalent != null) {
            // Update the properties of the existing customer with the new values
            existingTalent.setSchoolCode(talent.getSchoolCode());
            existingTalent.setSchoolName(talent.getSchoolName());
            existingTalent.setName(talent.getName());
            existingTalent.setGender(talent.getGender());
            existingTalent.setContact(talent.getContact());
            existingTalent.setEmail(talent.getEmail());
            existingTalent.setReason(talent.getReason());
            // Save the changes back to the database
            currentSession.merge(existingTalent);
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

    // New methods for interview management

    @Transactional
    public Talent findByEmail(String email) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Talent> query = currentSession.createQuery(
            "from Talent where email = :email", Talent.class);
        query.setParameter("email", email);
        List<Talent> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0);
    }

    @Transactional
    public void updateInterviewSchedule(int id, Date interviewDate, String interviewTime) {
        Session currentSession = sessionFactory.getCurrentSession();
        Talent talent = currentSession.get(Talent.class, id);
        if (talent != null) {
            talent.setInterviewDate(interviewDate);
            talent.setInterviewTime(interviewTime);
            talent.setApplicationStatus("SCHEDULED");
            currentSession.merge(talent);
        }
    }

    @Transactional
    public void updateInterviewResult(int id, String result) {
        Session currentSession = sessionFactory.getCurrentSession();
        Talent talent = currentSession.get(Talent.class, id);
        if (talent != null) {
            talent.setInterviewResult(result);
            talent.setApplicationStatus("INTERVIEWED");
            currentSession.merge(talent);
        }
    }

    @Transactional
    public List<Talent> findBySchoolCode(String schoolCode) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Talent> query = currentSession.createQuery(
            "from Talent where schoolCode = :schoolCode", Talent.class);
        query.setParameter("schoolCode", schoolCode);
        return query.getResultList();
    }

    @Transactional
    public List<Talent> findByStatus(String status) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Talent> query = currentSession.createQuery(
            "from Talent where applicationStatus = :status", Talent.class);
        query.setParameter("status", status);
        return query.getResultList();
    }

    @Transactional
    public List<Talent> findScheduledInterviews(Date date) {
        Session currentSession = sessionFactory.getCurrentSession();
        Query<Talent> query = currentSession.createQuery(
            "from Talent where interviewDate = :date", Talent.class);
        query.setParameter("date", date);
        return query.getResultList();
    }
}