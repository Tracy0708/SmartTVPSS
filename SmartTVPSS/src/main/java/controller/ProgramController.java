package controller;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import service.ProgramDao_usingHibernate;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entity.School;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/program")  // Changed from "/schools" to match pattern
public class ProgramController {
    
    @Autowired
    private ProgramDao_usingHibernate schoolDao;

    @RequestMapping("/tvpssteam/schoolList")  // Changed to match pattern
    public String listSchools(Model model) {
        List<School> schools = schoolDao.findAll();
        model.addAttribute("schoolList", schools);  // Changed to match pattern
        return "schoolList";  // Make sure this JSP exists
    }
    @GetMapping("/tvpssteam/timeline")
    public String showTimeline(Model model) {
        List<School> schools = schoolDao.findAll();
        model.addAttribute("schoolList", schools);
        return "timeline"; 
    }

    @RequestMapping("/tvpssteam/timeline")  // Changed to match pattern
    public String listTimeline(Model model) {
        // Changed to match pattern
        return "timeline";  // Make sure this JSP exists
    }
    
    @PostMapping("/tvpssteam/saveTimeline")
    @ResponseBody
    public ResponseEntity<?> saveTimeline(
        @RequestParam("schoolId") Integer schoolId,
        @RequestParam("timelineStart") String timelineStart,
        @RequestParam("timelineEnd") String timelineEnd) {
        
        try {
            School school = schoolDao.findById(schoolId);
            if (school == null) {
                return ResponseEntity.badRequest().body("School not found");
            }
            
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd MMM yyyy");
            // Parse to LocalDate first, then convert to LocalDateTime
            LocalDateTime startDate = LocalDate.parse(timelineStart, formatter).atStartOfDay();
            LocalDateTime endDate = LocalDate.parse(timelineEnd, formatter).atTime(23, 59, 59);
            
            school.setTimelineStart(startDate);
            school.setTimelineEnd(endDate);
            schoolDao.save(school);
            
            return ResponseEntity.ok().body("Timeline saved successfully");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.badRequest().body("Error saving timeline: " + e.getMessage());
        }
    }
    @GetMapping("/tvpssteam/add")
    public String showAddForm(Model model) {
        model.addAttribute("school", new School());
        return "addSchool";
    }

    @PostMapping("/tvpssteam/add")
    public String saveSchool(@ModelAttribute("school") School school, RedirectAttributes redirectAttributes) {
        schoolDao.save(school);
        redirectAttributes.addFlashAttribute("successMessage", "School added successfully!");
        return "redirect:/program/tvpssteam/schoolList";  // Redirects back to the school list
    }
    
    @GetMapping("/tvpssteam/edit/{id}")
    public String showEditForm(@PathVariable("id") int id, Model model) {
        School school = schoolDao.findById(id);
        model.addAttribute("school", school);
        return "editSchool";
    }
    
    @PostMapping("/tvpssteam/update")
    public String updateSchool(@ModelAttribute("school") School school, RedirectAttributes redirectAttributes) {
        schoolDao.save(school);  
        redirectAttributes.addFlashAttribute("successMessage", "School information has been updated successfully!");
        return "redirect:/program/tvpssteam/schoolList";
    }
    @GetMapping("/tvpssteam/delete")
    public String deleteSchool(@RequestParam("id") int id, RedirectAttributes redirectAttributes) {
        try {
            schoolDao.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "School deleted successfully!");
            return "redirect:/program/tvpssteam/schoolList";  // Redirect to the list page
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting school: " + e.getMessage());
            return "redirect:/program/tvpssteam/schoolList";
        }
    }

    @PostMapping("/delete")  // Changed to match pattern
    public String deleteSchool(HttpServletRequest request, Model model) {
        int id = Integer.parseInt(request.getParameter("id"));
        schoolDao.delete(id);
        model.addAttribute("id", id);
        return "confirmdeletedschool";  // Changed to match naming pattern
    }
    
    @GetMapping("/admin/edit/{id}")
    public String showAdminEditForm(@PathVariable("id") int id, Model model) {
        School school = schoolDao.findById(id);
        model.addAttribute("school", school);
        return "admineditSchool";
    }
    @PostMapping("/admin/updateSchool")
    public String updateAdminSchool(@RequestParam("id") Integer id, 
                                  @ModelAttribute School school, 
                                  RedirectAttributes redirectAttributes) {
        try {
            school.setId(id);
            schoolDao.update(id, school);
            redirectAttributes.addFlashAttribute("successMessage", "School information has been updated successfully!");
            return "redirect:/program/admin/edit/" + id;
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error updating school: " + e.getMessage());
            return "redirect:/program/admin/edit/" + id;
        }
    }
}