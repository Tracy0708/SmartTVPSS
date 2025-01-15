package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

import entity.Event;
import service.DashboardDao;

@RestController
@RequestMapping("/home/dashboard")
public class DashboardController {

    @Autowired
    private DashboardDao dashboardDao;

    // Save Event
    @PostMapping("/saveEvent")
    public ResponseEntity<String> saveEvent(@RequestBody Event event) {
        if (event.getTitle() == null || event.getStartDate() == null) {
            return ResponseEntity.badRequest().body("Title and Start Date are required!");
        }
        dashboardDao.saveEvent(event);
        return ResponseEntity.ok("Event saved successfully");
    }


    @GetMapping("/getEvents")
    public ResponseEntity<List<Event>> getEvents() {
        try {
            List<Event> events = dashboardDao.getAllEvents(); // Fetch all events from DB
            return ResponseEntity.ok(events);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(null);
        }
    }
    
    @DeleteMapping("/deleteEvent/{id}")
    public ResponseEntity<String> deleteEvent(@PathVariable int id) {
        try {
            dashboardDao.deleteEvent(id);
            return ResponseEntity.ok("Event deleted successfully");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Failed to delete event");
        }
    }
    
 // Update Event
    @PutMapping("/updateEvent")
    public ResponseEntity<String> updateEvent(@RequestBody Event event) {
        try {
            if (event.getId() == 0 || event.getTitle() == null || event.getStartDate() == null) {
                return ResponseEntity.badRequest().body("Invalid event data!");
            }
            dashboardDao.updateEvent(event);
            return ResponseEntity.ok("Event updated successfully");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Failed to update event: " + e.getMessage());
        }
    }


}