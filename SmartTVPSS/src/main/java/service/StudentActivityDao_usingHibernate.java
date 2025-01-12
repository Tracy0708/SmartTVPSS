package service;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import entity.Activity;
import entity.Participant;

import java.util.List;

@Service
public class StudentActivityDao_usingHibernate {
	@Autowired // spring dependency injection
	private SessionFactory sessionFactory;

	@Transactional
	public Participant findById(Integer participant_id) {
		Session currentSession = sessionFactory.getCurrentSession();
		return currentSession.get(Participant.class, participant_id);
	}

	@Transactional
	public String save(Participant participant) {
		Session currentSession = sessionFactory.getCurrentSession();
		
		// Fetch the activity associated with the participant
        Activity activity = currentSession.get(Activity.class, participant.getActivityId());
        if (activity.getCurrentParticipant() >= activity.getLimitation()) {
            return "Participant limit reached for this activity.";
        }
        
        // Increment the current participant count
        activity.setCurrentParticipant(activity.getCurrentParticipant() + 1);
        currentSession.saveOrUpdate(activity);

		currentSession.saveOrUpdate(participant);
		return "Registered successfully.";
	}

	@Transactional
	public void detach(Participant participant) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.evict(participant);
	}

	@Transactional
	public void update(Integer participant_id, Participant participant) {
		Session currentSession = sessionFactory.getCurrentSession();
		// Retrieve the persistent activity from the database using the provided id
		Participant existingParticipant = currentSession.get(Participant.class, participant_id);
		// Check if the activity exists before updating
		if (existingParticipant != null) {
			// Update the properties of the existing activity with the new values
			existingParticipant.setName(participant.getName());
			existingParticipant.setStudentID(participant.getStudentID());
			existingParticipant.setGender(participant.getGender());
			existingParticipant.setAge(participant.getAge());
			existingParticipant.setSchool(participant.getSchool());
			existingParticipant.setEmail(participant.getEmail());
			existingParticipant.setPhone(participant.getPhone());
			existingParticipant.setAddress(participant.getAddress());
			existingParticipant.setActivityId(participant.getActivityId());

			// Save the changes back to the database
			currentSession.merge(existingParticipant);
		}
	}

	@Transactional
	public void delete(Integer participant_id) {
	    Session currentSession = sessionFactory.getCurrentSession();

	    // Retrieve the participant
	    Participant participantToDelete = currentSession.get(Participant.class, participant_id);
	    if (participantToDelete != null) {
	        // Fetch the associated activity
	        Activity activity = getActivityById(participantToDelete.getActivityId());
	        if (activity != null) {
	            // Decrement the participant count
	            activity.setCurrentParticipant(activity.getCurrentParticipant() - 1);
	            updateActivity(activity);
	        }

	        // Delete the participant
	        currentSession.delete(participantToDelete);
	    }
	}

	@Transactional
	public List<Participant> findAll() {
		Session currentSession = sessionFactory.getCurrentSession();
		return currentSession.createQuery("from Participant", Participant.class).getResultList();
	}
	
	@Transactional
	public List<Participant> findParticipantsByActivityId(Integer activityId) {
	    Session currentSession = sessionFactory.getCurrentSession();
	    String hql = "FROM Participant WHERE activityId = :activityId";
	    return currentSession.createQuery(hql, Participant.class)
	                         .setParameter("activityId", activityId)
	                         .getResultList();
	}
	
	@Transactional
	public List<Participant> findPaginated(int pageNo, int pageSize) {
	    Session currentSession = sessionFactory.getCurrentSession();
	    return currentSession.createQuery("from Participant", Participant.class)
	                         .setFirstResult((pageNo - 1) * pageSize) // Start index
	                         .setMaxResults(pageSize)               // Limit to pageSize
	                         .getResultList();
	}

    @Transactional
    public long countTotalActivities() {
        Session currentSession = sessionFactory.getCurrentSession();
        return (long) currentSession.createQuery("select count(p.participant_id) from Participant p").uniqueResult();
    }
    
    @Transactional
    public List<Participant> getFilteredParticipant(Integer activityId, String search, String gender, int page, int pageSize) {
        // Construct the base query
        String hql = "FROM Participant WHERE activityId = :activityId";
        
        // Append filters dynamically
        if (search != null && !search.trim().isEmpty()) {
            hql += " AND lower(name) LIKE :search";
        }
        if (gender != null && !gender.trim().isEmpty()) {
            hql += " AND gender = :gender";
        }

        // Create the query
        Query<Participant> query = sessionFactory.getCurrentSession().createQuery(hql, Participant.class);
        query.setParameter("activityId", activityId);

        // Set dynamic parameters
        if (search != null && !search.trim().isEmpty()) {
            query.setParameter("search", "%" + search.toLowerCase() + "%");
        }
        if (gender != null && !gender.trim().isEmpty()) {
            query.setParameter("gender", gender);
        }

        // Apply pagination
        query.setFirstResult((page - 1) * pageSize);
        query.setMaxResults(pageSize);

        return query.getResultList();
    }

    @Transactional
    public int getFilteredParticipantCount(Integer activityId, String search, String gender) {
        // Construct the base count query
        String hql = "SELECT count(*) FROM Participant WHERE activityId = :activityId";
        
        // Append filters dynamically
        if (search != null && !search.trim().isEmpty()) {
            hql += " AND lower(name) LIKE :search";
        }
        if (gender != null && !gender.trim().isEmpty()) {
            hql += " AND gender = :gender";
        }

        // Create the query
        Query<Long> query = sessionFactory.getCurrentSession().createQuery(hql, Long.class);
        query.setParameter("activityId", activityId);

        // Set dynamic parameters
        if (search != null && !search.trim().isEmpty()) {
            query.setParameter("search", "%" + search.toLowerCase() + "%");
        }
        if (gender != null && !gender.trim().isEmpty()) {
            query.setParameter("gender", gender);
        }

        return query.uniqueResult().intValue();
    }
    
    @Transactional
    public Activity getActivityById(Integer activityId) {
        Session currentSession = sessionFactory.getCurrentSession();
        return currentSession.get(Activity.class, activityId);
    }

    @Transactional
    public void updateActivity(Activity activity) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.saveOrUpdate(activity);
    }

}