package service;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.TypedQuery;
import java.util.List;

import entity.Event;

@Repository
public class DashboardDao {

    @Autowired
    private SessionFactory sessionFactory;

    // Save Event
    public void saveEvent(Event event) {
        Session session = null;
        Transaction transaction = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.save(event);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            throw new RuntimeException("Failed to save event: " + e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }


    // Get All Events
    public List<Event> getAllEvents() {
        Session session = sessionFactory.openSession();
        TypedQuery<Event> query = session.createQuery("FROM Event", Event.class);
        List<Event> events = query.getResultList();
        session.close();
        return events;
    }
    
    public void deleteEvent(int id) {
        Session session = sessionFactory.openSession();
        Transaction transaction = session.beginTransaction();
        try {
            Event event = session.get(Event.class, id);
            if (event != null) {
                session.delete(event);
            }
            transaction.commit();
        } catch (Exception e) {
            transaction.rollback();
            throw new RuntimeException("Failed to delete event: " + e.getMessage());
        } finally {
            session.close();
        }
    }
    
    public void updateEvent(Event event) {
        Session session = null;
        Transaction transaction = null;
        try {
            session = sessionFactory.openSession();
            transaction = session.beginTransaction();
            session.update(event);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            e.printStackTrace();
            throw new RuntimeException("Failed to update event: " + e.getMessage());
        } finally {
            if (session != null) {
                session.close();
            }
        }
    }
}