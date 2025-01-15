package service;

import org.springframework.stereotype.Repository;
import entity.User;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

@Repository
@Transactional
public class HomeDao_usingHibernate {

    @PersistenceContext
    private EntityManager entityManager;

    public User findByEmail(String email) {
        try {
            return entityManager.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

    public void save(User user) {
        try {
            System.out.println("Saving user: " + user.getId());
            entityManager.merge(user); // Use merge for updates
            System.out.println("User saved successfully.");
        } catch (Exception e) {
            System.out.println("Error saving user: " + e.getMessage());
            throw e; // Re-throw the exception for the controller to handle
        }
    }


}
