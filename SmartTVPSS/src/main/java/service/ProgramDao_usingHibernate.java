package service;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import entity.School;

import java.time.LocalDateTime;
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
        School existingSchool = currentSession.get(School.class,  id);
        
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
        return findAllWithUpdatedStatus();
    }
    
    @Transactional
    private void updateSchoolStatus(School school) {
        LocalDateTime now = LocalDateTime.now();
        if (school.getStatus() == School.TimelineStatus.EXTENDED || 
            school.getStatus() == School.TimelineStatus.COMPLETE) {
            return;
        }
        
        if (school.getTimelineStart() == null || school.getTimelineEnd() == null) {
            school.setStatus(School.TimelineStatus.NOT_ASSIGNED);
        } else if (now.isBefore(school.getTimelineEnd())) {
            school.setStatus(School.TimelineStatus.ONGOING);
        } else if (now.isAfter(school.getTimelineEnd())) {
            school.setStatus(School.TimelineStatus.EXCEEDED);
        }
    }

    @Transactional
    public List<School> findAllWithUpdatedStatus() {
        Session currentSession = sessionFactory.getCurrentSession();
        List<School> schools = currentSession.createQuery("from School", School.class).getResultList();
        
        // Update status for each school
        for (School school : schools) {
            updateSchoolStatus(school);
            currentSession.update(school);
        }
        
        return schools;
    }
    @Transactional
    public List<School> findByExtensionRequested(boolean requested) {
        Session currentSession = sessionFactory.getCurrentSession();
        return currentSession.createQuery("from School where extensionRequested = :requested", School.class)
                .setParameter("requested", requested)
                .getResultList();
    }
    
    
}