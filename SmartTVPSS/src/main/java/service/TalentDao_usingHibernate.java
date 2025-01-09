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

}