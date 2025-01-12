package service;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import entity.School;
import java.util.List;

@Service
public class ProgramDao_usingHibernate {
    @Autowired
    private SessionFactory sessionFactory;
    
    @Transactional
    public School findById(int id) {
        Session currentSession = sessionFactory.getCurrentSession();
        return currentSession.get(School.class, id);
    }
    
    @Transactional
    public void save(School school) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.saveOrUpdate(school);
    }
    
    @Transactional
    public void detach(School school) {
        Session currentSession = sessionFactory.getCurrentSession();
        currentSession.evict(school);
    }
    
    @Transactional
    public void update(int id, School school) {
        Session currentSession = sessionFactory.getCurrentSession();
        // Retrieve the persistent school from the database using the provided id
        School existingSchool = currentSession.get(School.class, (long) id);
        
        // Check if the school exists before updating
        if (existingSchool != null) {
            // Update the properties of the existing school with the new values
            existingSchool.setSchoolCode(school.getSchoolCode());
            existingSchool.setSchoolName(school.getSchoolName());
            existingSchool.setHasLogo(school.isHasLogo());
            existingSchool.setHasStudioPss(school.isHasStudioPss());
            existingSchool.setHasInSchoolRecording(school.isHasInSchoolRecording());
            existingSchool.setHasYoutubeUpload(school.isHasYoutubeUpload());
            existingSchool.setYoutubeUrl(school.getYoutubeUrl());
            existingSchool.setHasExternalRecording(school.isHasExternalRecording());
            existingSchool.setHasExternalCollaboration(school.isHasExternalCollaboration());
            existingSchool.setHasGreenScreen(school.isHasGreenScreen());
            
            // Save the changes back to the database
            currentSession.merge(existingSchool);
        }
    }
    
    @Transactional
    public void delete(int id) {
        Session currentSession = sessionFactory.getCurrentSession();
        // Retrieve the persistent school from the database using the provided id
        School schoolToDelete = currentSession.get(School.class, (int) id);
        
        // Check if the school exists before deleting
        if (schoolToDelete != null) {
            // Delete the school from the database
            currentSession.delete(schoolToDelete);
        }
    }
    
    @Transactional
    public List<School> findAll() {
        Session currentSession = sessionFactory.getCurrentSession();
        return currentSession.createQuery("from School", School.class).getResultList();
    }
}