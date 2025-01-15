package service;

import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import entity.User;

@Service
public class UserDao_usingHibernate {
    
    @Autowired
    private SessionFactory sessionFactory;

    @Transactional
    public User findById(String id) {
        return sessionFactory.getCurrentSession().get(User.class, id);
    }

    // Save or update a user
    @Transactional
    public void save(User user) {
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            // Example: Encrypt password (use a proper encryption library in production)
            user.setPassword(encryptPassword(user.getPassword()));
        }
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.saveOrUpdate(user);
    }

    private String encryptPassword(String password) {
        // Example of hashing (use a library like BCrypt for better security)
        return Integer.toHexString(password.hashCode());
    }

    @Transactional
    public void update(String id, User user) {
        Session session = sessionFactory.getCurrentSession();
        User existingUser = session.get(User.class, id);
        if (existingUser != null) {
            existingUser.setName(user.getName());
            existingUser.setEmail(user.getEmail());
            existingUser.setRole(user.getRole());
            if (user.getPassword() != null && !user.getPassword().isEmpty()) {
                existingUser.setPassword(user.getPassword());
            }
            session.merge(existingUser);
        }
    }

    @Transactional
    public void delete(String id) {
        Session session = sessionFactory.getCurrentSession();
        User user = session.get(User.class, id);
        if (user != null) {
            session.delete(user);
            session.flush();
        } else {
            throw new IllegalArgumentException("User not found with ID: " + id);
        }
    }


    @Transactional
    public List<User> findAll() {
        return sessionFactory.getCurrentSession()
                .createQuery("from User", User.class)
                .getResultList();
    }
    
    @Transactional
    public int countUsers(String search, String role) {
        Session session = sessionFactory.getCurrentSession();
        String queryStr = "SELECT COUNT(u) FROM User u WHERE (:search IS NULL OR u.name LIKE :search) AND (:role IS NULL OR u.role = :role)";
        Long count = session.createQuery(queryStr, Long.class)
                .setParameter("search", search != null ? "%" + search + "%" : null)
                .setParameter("role", role)
                .uniqueResult();
        return count.intValue();
    }

}