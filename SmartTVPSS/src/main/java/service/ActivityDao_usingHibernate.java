package service;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import entity.Activity;
import java.util.List;

@Service
public class ActivityDao_usingHibernate {
	@Autowired // spring dependency injection
	private SessionFactory sessionFactory;

	@Transactional
	public Activity findById(Integer id) {
		Session currentSession = sessionFactory.getCurrentSession();
		return currentSession.get(Activity.class, id);
	}

	@Transactional
	public void save(Activity activity) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.saveOrUpdate(activity);
	}

	@Transactional
	public void detach(Activity activity) {
		Session currentSession = sessionFactory.getCurrentSession();
		currentSession.evict(activity);
	}

	@Transactional
	public void update(Integer id, Activity activity) {
		Session currentSession = sessionFactory.getCurrentSession();
		// Retrieve the persistent activity from the database using the provided id
		Activity existingActivity = currentSession.get(Activity.class, id);
		// Check if the activity exists before updating
		if (existingActivity != null) {
			// Update the properties of the existing activity with the new values
			existingActivity.setActivityName(activity.getActivityName());
			existingActivity.setOrganizer(activity.getOrganizer());
			existingActivity.setStartDate(activity.getStartDate());
			existingActivity.setEndDate(activity.getEndDate());
			existingActivity.setPic(activity.getPic());
			existingActivity.setPhone(activity.getPhone());
			existingActivity.setLocation(activity.getLocation());
			existingActivity.setDescription(activity.getDescription());
			existingActivity.setActivityType(activity.getActivityType());
			existingActivity.setActivityLevel(activity.getActivityLevel());
			existingActivity.setLimitation(activity.getLimitation());

			// Save the changes back to the database
			currentSession.merge(existingActivity);
		}
	}

	@Transactional
	public void delete(Integer id) {
		Session currentSession = sessionFactory.getCurrentSession();

		// Retrieve the persistent activity from the database using the provided id
		Activity activityToDelete = currentSession.get(Activity.class, id);

		// Check if the activity exists before deleting
		if (activityToDelete != null) {
			// Delete the activity from the database
			currentSession.delete(activityToDelete);
		}
	}

	@Transactional
	public List<Activity> findAll() {
		Session currentSession = sessionFactory.getCurrentSession();
		return currentSession.createQuery("from Activity").getResultList();
	}
	
	@Transactional
	public List<Activity> findPaginated(int pageNo, int pageSize) {
	    Session currentSession = sessionFactory.getCurrentSession();
	    return currentSession.createQuery("from Activity", Activity.class)
	                         .setFirstResult((pageNo - 1) * pageSize) // Start index
	                         .setMaxResults(pageSize)               // Limit to pageSize
	                         .getResultList();
	}

    @Transactional
    public long countTotalActivities() {
        Session currentSession = sessionFactory.getCurrentSession();
        return (long) currentSession.createQuery("select count(a.id) from Activity a").uniqueResult();
    }
    
    @Transactional
    public List<Activity> getFilteredActivities(String search, String type, String level, int page, int pageSize) {
        String hql = "FROM Activity WHERE 1=1";
        if (!search.isEmpty()) {
            hql += " AND activityName LIKE :search";
        }
        if (!type.isEmpty()) {
            hql += " AND activityType = :type";
        }
        if (!level.isEmpty()) {
            hql += " AND activityLevel = :level";
        }

        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        if (!search.isEmpty()) {
            query.setParameter("search", "%" + search + "%");
        }
        if (!type.isEmpty()) {
            query.setParameter("type", type);
        }
        if (!level.isEmpty()) {
            query.setParameter("level", level);
        }

        query.setFirstResult((page - 1) * pageSize);
        query.setMaxResults(pageSize);

        return query.list();
    }

    @Transactional
    public int getFilteredActivitiesCount(String search, String type, String level) {
        String hql = "SELECT count(*) FROM Activity WHERE 1=1";
        if (!search.isEmpty()) {
            hql += " AND activityName LIKE :search";
        }
        if (!type.isEmpty()) {
            hql += " AND activityType = :type";
        }
        if (!level.isEmpty()) {
            hql += " AND activityLevel = :level";
        }

        Query query = sessionFactory.getCurrentSession().createQuery(hql);
        if (!search.isEmpty()) {
            query.setParameter("search", "%" + search + "%");
        }
        if (!type.isEmpty()) {
            query.setParameter("type", type);
        }
        if (!level.isEmpty()) {
            query.setParameter("level", level);
        }

        return ((Long) query.uniqueResult()).intValue();
    }

}
